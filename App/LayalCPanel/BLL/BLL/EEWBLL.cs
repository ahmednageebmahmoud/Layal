﻿using BLL.Enums;
using BLL.Services;
using BLL.SignalAr;
using BLL.ViewModels;
using Google.Apis.Calendar.v3.Data;
using Resources;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.BLL
{
    public class EEWBLL : BasicBLL
    {

        NotificationsBLL NotificationsBLL = new NotificationsBLL();

        public object GetEventCoordinations(long eventId)
        {

            var EventCoordinations = db.EventCoordinations_SelectByEventId(eventId)
                .Select(c => new EventCoordinationVM
                {
                    Id = c.Id,
                    EndTime = c.EndTime,
                    EventId = c.FKEvent_Id,
                    Notes = c.Notes,
                    StartTime = c.StartTime,
                    Task = c.Task,
                    UserCreatedId = c.FKUserCreated_Id,
                    TaskNumber = c.TaskNumber,
                    CreatedUserName = c.UserName,
                    EventWorkStatusIsFinshed = new EventWorksStatusIsFinshedVM
                    {
                        Coordination = c.Coordination,
                    }

                }).ToList();
            return new ResponseVM(Enums.RequestTypeEnum.Success, Token.Success, EventCoordinations);
        }


        /// <summary>
        /// التحقق ان الموظف الحالى يمكنة الوصول الى الصفحة
        /// </summary>
        /// <returns></returns>
        public bool ChakIfEmployeeAllowAccess(WorksTypesEnum workType)
        {
            if (this.UserLoggad.IsAdmin) return true;

            return db.EmployeesWorks_CheckIfInserted((int)workType, this.UserLoggad.Id).First().Value > 0;
        }


        public object GetEventForCurrretnEmployee(long eventId, WorksTypesEnum workType)
        {
            if (!CheckAlloweAccess(eventId, workType))
                return new ResponseVM(RequestTypeEnum.Error, Token.YouCanNotAccessToThisEvent);

            return new EventsBLL().GetEventForCurrretnEmployee(eventId);
        }


        /// <summary>
        /// التحقق ان المستخدم الحالى يحق لة التغير فى الاعدادات
        /// </summary>
        /// <param name="evenId"></param>
        /// <returns></returns>
        public bool CheckAlloweAccess(long evenId, WorksTypesEnum workType)
        {
            return db.Employees_CheckAllowAccessToEventForUpdateWorks(
                this.UserLoggad.IsAdmin,
                this.UserLoggad.IsClinet,
                this.UserLoggad.IsBranchManager,
                evenId,
                (int)workType,
                this.UserLoggad.Id,
                this.UserLoggad.BrId).First().Value > 0;

        }

        public object TaskFinsh(long eventId, WorksTypesEnum workTypeId)
        {
            try
            {
                //Check 
                var ObjReturn = CheckIfAllowSave(eventId, workTypeId);
                if (ObjReturn != null) return ObjReturn;


                //Insert In History
                db.EventWorksStatusHistory_Insert(true, DateTime.Now, eventId, (int)workTypeId, this.UserLoggad.Id, this.UserLoggad.AccountTypeId);

                //Update Event Finshed
                UpdateFinshed(eventId, workTypeId);

                //Send Notification
                SaveNotificationFinshTask(eventId, workTypeId);

                return new ResponseVM(RequestTypeEnum.Success, Token.Finshed);
            }
            catch (Exception ex)
            {
                return new ResponseVM(RequestTypeEnum.Error, Token.SomeErrorHasBeen, ex);
            }
        }

        /// <summary>
        /// التحقق بان المستخدم يمكنة استكامل عملية الحفظ بناء على التحققات المخصصة لكل نوع عمل 
        /// </summary>
        /// <param name="eventId"></param>
        /// <param name="workTypeId"></param>
        /// <returns></returns>
        private object CheckIfAllowSave(long eventId, WorksTypesEnum workTypeId)
        {
            //التحقق من امكانية الوصول الى المناسبة
            if (!CheckAlloweAccess(eventId, workTypeId))
                return new ResponseVM(RequestTypeEnum.Error, Token.YouCanNotAccessToThisEvent);

            //التحقق ان هذة المهمة لم تنتهى بعد
            if (db.EventWorksStatusIsFinsed_CheckIfFinshed(eventId, (int)workTypeId).First().Value)
                return new ResponseVM(RequestTypeEnum.Error, Token.ThisTaskIsFinshed);

            //التحقق لان المناسبة لم تغلق
            if (CheckIfEnquiryClosed(eventId))
                return new ResponseVM(RequestTypeEnum.Error, Token.EventIsClosed);

            switch (workTypeId)
            {
                case WorksTypesEnum.Booking:
                    break;
                case WorksTypesEnum.DataPerfection:
                    break;
                case WorksTypesEnum.Coordination:
                    {
                        //التحقق ان المناسبة لم تبداء فى حالة الاعداد والتنسيق فقط
                        if (db.Events_CheckFromDateEventIsFinshed(eventId, DateTime.Now).First().Value > 0)
                            return new ResponseVM(RequestTypeEnum.Error, Token.ThisEventDateIsFinshed);
                    }
                    break;
                case WorksTypesEnum.Implementation:
                    break;
                case WorksTypesEnum.ArchivingAndSaveing:
                    break;
                case WorksTypesEnum.ProductProcessing:
                    break;
                case WorksTypesEnum.Chooseing:
                    break;
                case WorksTypesEnum.DigitalProcessing:
                    break;
                case WorksTypesEnum.PreparingForPrinting:
                    break;
                case WorksTypesEnum.Manufacturing:
                    break;
                case WorksTypesEnum.QualityAndReview:
                    break;
                case WorksTypesEnum.Packaging:
                    break;
                case WorksTypesEnum.TransmissionAndDelivery:
                    break;
                case WorksTypesEnum.Archiving:
                    break;
                default:
                    return null;
            }
            return null;
        }

        /// <summary>
        /// تحديث انهاء المهمة نهائيا بناء على نوعها
        /// لان بعد المهمات بعد ان تنتهى من الموظف تحتاج الى المراجعة
        /// وهناك مهمات تنتهى من الموظف مباشرة ويجب حينها انهائها تمام
        /// </summary>
        /// <param name="eventId"></param>
        /// <param name="workTypeId"></param>
        private void UpdateFinshed(long eventId, WorksTypesEnum workTypeId)
        {
            switch (workTypeId)
            {
                case WorksTypesEnum.Coordination:
                case WorksTypesEnum.Implementation:
                    //فى هذة الحالات لا نحتاج الى مراجعة 
                    db.EventWorksStatusIsFinshed_Update(eventId, true, (int)workTypeId);
                    break;
                case WorksTypesEnum.ArchivingAndSaveing:
                    break;
                case WorksTypesEnum.ProductProcessing:
                    break;
                case WorksTypesEnum.Chooseing:
                    break;
                case WorksTypesEnum.DigitalProcessing:
                    break;
                case WorksTypesEnum.PreparingForPrinting:
                    break;
                case WorksTypesEnum.Manufacturing:
                    break;
                case WorksTypesEnum.QualityAndReview:
                    break;
                case WorksTypesEnum.Packaging:
                    break;
                case WorksTypesEnum.TransmissionAndDelivery:
                    break;
                case WorksTypesEnum.Archiving:
                    break;
                default:
                    break;
            }



        }

        private void SaveNotificationFinshTask(long eventId, WorksTypesEnum workTypeId)
        {
            //اذا كان الستخدم الحالى ليس هوا مدير الفرع فيجب ارسال اشعار لـ مدير الفرع
            if (!this.UserLoggad.IsBranchManager)
            {
                var Notify = new NotifyVM
                {
                    DateTime = DateTime.Now,
                    TargetId = eventId,
                    PageId = (int)PagesEnum.Enquires,
                    RedirectUrl = $"/WorkFlow?id={eventId}&notifyId=",
                };

                switch (workTypeId)
                {
                    case WorksTypesEnum.Booking:
                        break;
                    case WorksTypesEnum.DataPerfection:
                        break;
                    case WorksTypesEnum.Coordination:
                        {
                            Notify.TitleAr = " الانتهاء من الاعداد والتنسيق";
                            Notify.TitleEn = "Coordinations Finshed";
                            Notify.DescriptionAr = $"لقد قام الموظف { this.UserLoggad.UserName } بـ انهاء مهام الاعداد والتنسيق للمناسبة ";
                            Notify.DescriptionEn = $"{ this.UserLoggad.UserName } Has been finshed coordinations for event";
                        }
                        break;
                    case WorksTypesEnum.Implementation:
                        break;
                    case WorksTypesEnum.ArchivingAndSaveing:
                        break;
                    case WorksTypesEnum.ProductProcessing:
                        break;
                    case WorksTypesEnum.Chooseing:
                        break;
                    case WorksTypesEnum.DigitalProcessing:
                        break;
                    case WorksTypesEnum.PreparingForPrinting:
                        break;
                    case WorksTypesEnum.Manufacturing:
                        break;
                    case WorksTypesEnum.QualityAndReview:
                        break;
                    case WorksTypesEnum.Packaging:
                        break;
                    case WorksTypesEnum.TransmissionAndDelivery:
                        break;
                    case WorksTypesEnum.Archiving:
                        break;
                    default:
                        break;
                }


                var UserMangerBranch = db.Users_SelectByBranchId(this.UserLoggad.BrId, (int)AccountTypeEnum.BranchManager).FirstOrDefault();
                if (UserMangerBranch != null)
                {
                    NotificationsBLL.Add(Notify, UserMangerBranch.Id);
                    new NotificationHub().SendNotificationToSpcifcUsers(new List<string> { UserMangerBranch.Id.ToString() }, Notify);
                }
            }
        }

        private bool CheckIfEnquiryClosed(long enquiryId)
        {
            return db.Enquires_IsClosed(enquiryId).First().Value > 0;
        }

        private object Delete(EventCoordinationVM c)
        {
            db.EventCoordinations_Delete(c.Id);
            return new ResponseVM(RequestTypeEnum.Success, Token.Deleted);
        }


        private object Add(EventCoordinationVM c)
        {

            //Get Task Number
            GetTaskNumber(c);

            db.EventCoordinations_Insert(c.TaskNumber, c.Task, c.StartTime, c.EndTime, c.Notes, c.EventId, this.UserLoggad.Id);

            return new ResponseVM(RequestTypeEnum.Success, $"{Token.AddedWithTaskumber} : {c.TaskNumber}",
                db.EventCoordinations_SelectByEventId(c.EventId)
                .Select(v => new EventCoordinationVM
                {
                    Id = v.Id,
                    EndTime = v.EndTime,
                    EventId = v.FKEvent_Id,
                    Notes = v.Notes,
                    StartTime = v.StartTime,
                    Task = v.Task,
                    UserCreatedId = v.FKUserCreated_Id,
                    TaskNumber = v.TaskNumber,
                    CreatedUserName = v.UserName,
                }).ToList());
        }

        void GetTaskNumber(EventCoordinationVM c)
        {
            int TaskNum = 1;
            db.EventCoordinations_SelectTasksNumber(c.EventId).OrderBy(v => v).Select(v => v.Value).ToList().ForEach(tn =>
            {
                if (tn == TaskNum)
                    TaskNum += 1;
            });

            c.TaskNumber = TaskNum;
        }


    }//end class
}