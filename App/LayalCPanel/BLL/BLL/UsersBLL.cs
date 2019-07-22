﻿using BLL.Enums;
using BLL.Services;
using BLL.ViewModels;
using DAL.Service;
using Resources;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.BLL
{
    public class UsersBLL : BasicBLL
    {

        public object GetUsers(int? skip, int? take, string userName, string email, string phoneNumber, string adddress,
            DateTime? createDateTo, DateTime? createDateFrom, int? countryId, int? cityId, int? accountTypeId, int? languageId)

        {
            var Users = db.Users_SelectByFilter(skip, take, userName, email, phoneNumber, adddress, createDateTo, createDateFrom,
                countryId, cityId, accountTypeId, languageId).Select(c => new UserVM
                {
                    Id = c.Id,
                    UserName = c.UserName,
                    AccountTypeId = c.FKAccountType_Id,
                    Address = c.Address,
                    Email = c.Email,
                    PhoneNo = c.PhoneNo,
                    City = new CityVM
                    {
                        Id = c.FkCity_Id,
                        NameAr = c.CityNameAr,
                        NameEn = c.CityNameEn
                    },
                    Country = new CountryVM
                    {
                        Id = c.FkCountry_Id,
                        NameAr = c.CountryNameAr,
                        NameEn = c.CountryNameEn
                    },
                    AccountType = new AccountTypeVM
                    {
                        Id = c.FKAccountType_Id,
                        NameEn = c.AccountTypeNameEn,
                        NameAr = c.AccountTypeNameAr,
                    },
                    _Language = (LanguageEnum)c.FKLanguage_Id,
                }).ToList();

            if (Users.Count == 0)
            {
                if (skip == 0)
                    return new ResponseVM(Enums.RequestTypeEnum.Info, Token.NoResult);

                return new ResponseVM(Enums.RequestTypeEnum.Info, Token.NoMoreResult);
            }

            return new ResponseVM(Enums.RequestTypeEnum.Success, Token.Success, Users);
        }

        public object SendActiveCodeToEmail(long id, string email, string userName)
        {
            try
            {
                //check if this email befor use
                if (db.User_EmailBeforUsed(id, email).FirstOrDefault() > 0)
                    return new ResponseVM(RequestTypeEnum.Error, Token.EmailItIsAlreadyUsed);

                string ActiveCode = $"C-{new Random().Next(9999, 20000)}";
                //SaveCode 
                db.Users_UpateActiveCodeAndEmail(id, ActiveCode, email);


                //هذا الكود مفعل بشكل موقت
                return new ResponseVM(RequestTypeEnum.Success, Token.Success);

                //Send Email
                EmailService.SendActiveCode(email, userName, ActiveCode);


                return new ResponseVM(RequestTypeEnum.Success, Token.Success);

            }
            catch (Exception ex)
            {


                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);

            }

        }

        public object ActiveEmail(long id, string activeCode)
        {
            try
            {
                var User = db.Users_ActiveEmail(id, activeCode).Select(c => new UserCookieVM
                {
                    Id = c.Id,
                    UserName = c.UserName,
                    AccountTypeId = c.FKAccountType_Id,
                    _Language = (LanguageEnum)c.FKLanguage_Id,
                    BrId = c.FKPranch_Id.HasValue ? c.FKPranch_Id.Value : 0,
                    IsActiveEmail = c.IsActiveEmail,
                    Email = c.Email
                }).FirstOrDefault();

                if (!User.IsActiveEmail)
                    return new ResponseVM(RequestTypeEnum.Error, Token.NotActivated);
                return new ResponseVM(RequestTypeEnum.Success, Token.Activated, User);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        public object ChangeLanguage(int languageId)
        {
            try
            {
                UserCookieVM User = db.Users_UpdateLangage(this.UserLoggad.Id, languageId).Select(c => new UserCookieVM
                {
                    Id = c.Id,
                    UserName = c.UserName,
                    AccountTypeId = c.FKAccountType_Id,
                    _Language = (LanguageEnum)c.FKLanguage_Id,
                    _IsRemmeberMe = this.UserLoggad._IsRemmeberMe,
                }).FirstOrDefault();

                if (User == null)
                    return new ResponseVM(Enums.RequestTypeEnum.Error, Token.InvalidUserNameOrPassword);

                //Set User In Cookie
                CookieService.SetUserInCookie(User);
                User.Id = 0;

                return new ResponseVM(RequestTypeEnum.Success, Token.Updated, User);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        public object SaveChange(UserVM c)
        {

            using (var tranc = db.Database.BeginTransaction())
            {
                try
                {
                    var ObjectReturn = new object();
                    switch (c.State)
                    {
                        case StateEnum.Create:
                            ObjectReturn = Add(c);
                            break;
                        case StateEnum.Update:
                            ObjectReturn = Update(c);
                            break;
                        case StateEnum.Delete:
                            ObjectReturn = Delete(c); break;
                            break;
                        default:
                            return new ResponseVM(RequestTypeEnum.Error, Token.StateNotFound);
                    }
                    tranc.Commit();
                    return ObjectReturn;
                }
                catch (Exception ex)
                {
                    tranc.Rollback();
                    return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
                }
            }
        }

        private object Delete(UserVM user)
        {
            throw new NotImplementedException();
        }

        private object Update(UserVM c)
        {
            if (db.User_UserNameBeforUsed(c.Id, c.UserName).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.UserNameItIsAlreadyUsed, c);

            if (db.User_EmailBeforUsed(c.Id, c.Email).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.EmailItIsAlreadyUsed, c);

            if (db.User_PhoneNumberBeforUsed(c.Id, c.PhoneNo).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.PhoneItIsAlreadyUsed, c);

            //check from active code 
            if (c.ActiveCode != null)
            {
                int Valid = db.Users_CheckFromActiveCode(c.Id, c.ActiveCode).First().Value;
                if (Valid == 0)
                    return new ResponseVM(RequestTypeEnum.Error, Token.InvalidActiveCode, c);
            }

            db.Users_Update(c.Id, c.UserName, c.Email, c.PhoneNo, c.Address, c.CountryId, c.CityId, c.Password, c.LanguageId, c.DateOfBirth, c.IsActive);



            //Add WorksTypes if employee
            if (c.AccountTypeId == (int)AccountTypeEnum.Employee && c.WorkTypes!=null&& c.WorkTypes.Count > 0)
            {
                //delete old works
                db.EmployeesWorks_Delete(c.Id);
                //add new 
                c.WorkTypes.Where(v => v.Selected).ToList().ForEach(v =>
                {
                    db.EmployeesWorks_Insert(v.Id, c.Id);
                });
            }

            return new ResponseVM(RequestTypeEnum.Success, Token.Updated, c);
        }

        private object Add(UserVM c)
        {
            //التحقق من صلاحيات المستخدم والتحقق من عدم انشاء حساب من قبل
            if (c.EnquiryId.HasValue)
            {
                var Enquiry = db.Enquires_SelectByPk_SimpleData(c.EnquiryId.Value).FirstOrDefault();
                if (Enquiry == null)
                    return new ResponseVM(RequestTypeEnum.Error, $"{Token.Enquiry}: {Token.UserNotFound}");

                if (Enquiry.CountIsDepositPaymented<=0 )
                    return new ResponseVM(RequestTypeEnum.Error, Token.ClinetIsNotPayment);


                if (Enquiry.IsLinkedClinet.HasValue && Enquiry.IsLinkedClinet.Value)
                    return new ResponseVM(RequestTypeEnum.Error, Token.ThisEnquiryAlreadyLinkedWithClinet);


                if (this.AdminId != this.UserLoggad.Id && Enquiry.FKBranch_Id != this.UserLoggad.BrId)
                    return new ResponseVM(RequestTypeEnum.Error, Token.YouCanNotAccessToCreateAccont);
            }

            if (db.User_UserNameBeforUsed(c.Id, c.UserName).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.UserNameItIsAlreadyUsed, c);

            if (db.User_EmailBeforUsed(c.Id, c.Email).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.EmailItIsAlreadyUsed, c);

            if (db.User_PhoneNumberBeforUsed(c.Id, c.PhoneNo).FirstOrDefault() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.PhoneItIsAlreadyUsed, c);

            //لا يمكن اضافة مديرين فرع لـ نفس الشخص
            if (c.AccountTypeId == (int)AccountTypeEnum.BranchManager && db.Users_SelectByBranchId(c.BranchId, c.AccountTypeId).Count() > 0)
                return new ResponseVM(RequestTypeEnum.Error, Token.CanNotDuplicateBranchManger, c);


            ObjectParameter ID = new ObjectParameter("Id", typeof(long));
            db.Users_Insert(ID, c.UserName, c.Email, c.PhoneNo, c.AccountTypeId, c.Address, c.CountryId, c.CityId, c.Password, null, DateTime.Now, c.LanguageId, c.BranchId, c.EnquiryId, c.DateOfBirth,c.IsActive);
            c.Id = (long)ID.Value;

            //Add WorksTypes if employee
            if (c.AccountTypeId == (int)AccountTypeEnum.Employee && c.WorkTypes.Count > 0)
            {
                c.WorkTypes.Where(v => v.Selected).ToList().ForEach(v =>
                 {
                     db.EmployeesWorks_Insert(v.Id, c.Id);
                 });
            }

            return new ResponseVM(RequestTypeEnum.Success, Token.Added, c);
        }

        public object SelectById(long? id)
        {
            if (!id.HasValue)
                id = this.UserLoggad.Id;
            var User = db.Users_SelectByPk(id).Select(c => new UserVM
            {
                Id = c.Id,
                UserName = c.UserName,
                AccountTypeId = c.FKAccountType_Id,
                Address = c.Address,
                Email = c.Email,
                PhoneNo = c.PhoneNo,
                CityId = c.FkCity_Id,
                CountryId = c.FkCountry_Id,
                LanguageId = c.FKLanguage_Id,
                DateOfBirth = c.DateOfBirth,
                IsActive=c.IsActive,

                City = new CityVM
                {
                    Id = c.FkCity_Id,
                    NameAr = c.CityNameAr,
                    NameEn = c.CityNameEn
                },
                Country = new CountryVM
                {
                    Id = c.FkCountry_Id,
                    NameAr = c.CountryNameAr,
                    NameEn = c.CountryNameEn
                },
                AccountType = new AccountTypeVM
                {
                    Id = c.FKAccountType_Id,
                    NameEn = c.AccountTypeNameEn,
                    NameAr = c.AccountTypeNameAr,
                },

                _Language = (LanguageEnum)c.FKLanguage_Id,
                WorkTypes=db.EmployeesWorks_SelectByUserId(id).Select(v=> new WorkTypeVM
                {
                    Id=v.FkWorkType_Id,
                    Selected=true,
                }).ToList()


            }).FirstOrDefault();

            if (User == null)
                return new ResponseVM(Enums.RequestTypeEnum.Error, Token.UserNotFound);

            return new ResponseVM(Enums.RequestTypeEnum.Success, Token.Success, User);
        }
    }//end class
}
