﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.ViewModels;
using BLL.Enums;
using Resources;
using System.Data.Entity.Core.Objects;

namespace BLL.BLL
{
    public class PackagesBLL : BasicBLL
    {
        public object GetPackages(int? skip, int? take)
        {
            var Packages = db.Packages_SelectByPaging(skip, take).Select(c => new PackageVM
            {
                Id = c.Id,
                NameAr = c.NameAr,
                NameEn = c.NameEn,
                DescriptionAr = c.DescriptionAr,
                DescriptionEn = c.DescriptionEn,
                IsAllowPrintNames = c.IsAllowPrintNames,
                WordDescriptionId = c.FkWordDescription_Id,
                WordNameId = c.FkWordName_Id
            }).ToList();
            if (Packages.Count == 0)
            {
                if (skip == 0)
                    return new ResponseVM(RequestTypeEnum.Error, Token.NoResult);
                return new ResponseVM(RequestTypeEnum.Error, Token.NoMoreResult);

            }

            return new ResponseVM(RequestTypeEnum.Success, Token.Success, Packages);


        }

        public object SaveChange(PackageVM c)
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

        private object Delete(PackageVM c)
        {
            try
            {
                if (db.Package_CheckIfUsed(c.Id).First().Value > 0)
                    return new ResponseVM(RequestTypeEnum.Error, Token.CanNotDeleteBecuseIsUsed);

                db.Packages_Delete(c.Id, c.WordNameId, c.WordDescriptionId);
                return new ResponseVM(RequestTypeEnum.Success, Token.Deleted, c);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        public object SaveChangePackageDeail(PackageDetailVM c)
        {
            throw new NotImplementedException();
        }

        private object Update(PackageVM c)
        {
            try
            {
                db.Packages_Update(c.Id, c.NameAr, c.NameEn, c.DescriptionAr, c.DescriptionEn, c.IsAllowPrintNames, c.AlbumTypeId, c.WordNameId, c.WordDescriptionId);
                return new ResponseVM(RequestTypeEnum.Success, Token.Updated, c);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        private object Add(PackageVM c)
        {
            try
            {
                ObjectParameter ID = new ObjectParameter("Id", typeof(int));
                db.Packages_Insert(ID, c.NameAr, c.NameEn, c.DescriptionAr, c.DescriptionEn, c.IsAllowPrintNames, c.AlbumTypeId);

                c.Id = (int)ID.Value;
                return new ResponseVM(RequestTypeEnum.Success, Token.Added, c);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        public object SelectById(int id)
        {
            var Package = db.Packages_SelectByPK(id).GroupBy(c => new
            {
                c.Id,
                c.DescriptionAr,
                c.DescriptionEn,
                c.FKAlbumType_Id,
                c.FkWordDescription_Id,
                c.FkWordName_Id,
                c.IsAllowPrintNames,
                c.NameAr,
                c.NameEn,
            }).Select(c => new PackageVM
            {
                Id = c.Key.Id,
                AlbumTypeId = c.Key.FKAlbumType_Id,
                DescriptionAr = c.Key.DescriptionAr,
                DescriptionEn = c.Key.DescriptionEn,
                NameAr = c.Key.NameAr,
                NameEn = c.Key.NameEn,
                IsAllowPrintNames = c.Key.IsAllowPrintNames,
                WordDescriptionId = c.Key.FkWordDescription_Id,
                WordNameId = c.Key.FkWordName_Id,

                PackageDetails = c.Where(x => x.PackageDetailsId.HasValue).Select(v => new PackageDetailVM
                {
                    Id = v.PackageDetailsId,
                    ValueAr = v.PackageDetailValueAr,
                    ValueEn = v.PackageDetailValueEn,
                    PackageInputTypeId = v.FKPackageInputType_Id
                }).ToList()

            }).FirstOrDefault();

            if (Package == null)
                return new ResponseVM(RequestTypeEnum.Error, $"{Token.Package} : {Token.NotFound}");

            return new ResponseVM(RequestTypeEnum.Success, Token.Success, Package);
        }
    }//end class
}
