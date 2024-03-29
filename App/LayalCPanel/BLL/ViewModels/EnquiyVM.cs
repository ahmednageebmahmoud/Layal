﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Bll.ViewModels;
using BLL.Enums;
using BLL.Services;
using BLL.ViewModels;

namespace BLL.ViewModels
{
    public class EnquiyVM : BasicVM
    {
        public long Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNo { get; set; }
        public int AccountTypeId { get; set; }
        public int CountryId { get; set; }
        public int PhoneCountryId { get; set; }
        public string PhoneIsoCode { get; set; }
        public string PhoneFull => $"{this.PhoneIsoCode}    {this.PhoneNo}";
        
        public int CityId { get; set; }
        public int? EnquiryTypeId { get; set; }
        public long? UserCreatedId { get; set; }
        public string UserCreatedName { get; set; }
        public int Day { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public int? BranchId { get; set; }
        public bool? IsClosed { get; set; }
        public object Status { get; set; }
        public bool? IsDepositPaymented { get; set; }
        public string ClendarEventId { get; set; }
        public bool? IsLinkedClinet { get; set; } 
        public DateTime CreateDateTime { get; set; }
        public DateTime? ClosedDateTime { get; set; }
        public string CreateDateTimeDisplay => DateService.GetDateTimeAr(this.CreateDateTime);
        public string ClosedDateTimeDisplay => DateService.GetDateTimeAr(this.ClosedDateTime);
        public long? ClinetId { get; set; }
        public string EventDate
        {
            get
            {
                return
                    $"{Month}/{Day}/{Year}";
            }
        }
        public CountryVM Country { get; set; }
        public CityVM City { get; set; }
        public EnquiryTypeVM EnquiryType { get; set; }
        public List<NoteVM> Notes { get; set; }
        public BranchVM Branch { get; set; }
        public bool IsCreatedEvent { get;   set; }
        public bool IsCanBeAccess => this.UserLoggad.IsAdmin || this.BranchId == this.UserLoggad.BrId;

        public EventVM Event { get;  set; }
        public List<EnquiryPaymentVM> Payments { get; internal set; }
    }//endclass
}
