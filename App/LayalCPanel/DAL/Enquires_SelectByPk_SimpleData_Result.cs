//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL
{
    using System;
    
    public partial class Enquires_SelectByPk_SimpleData_Result
    {
        public long Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNo { get; set; }
        public int FkCountry_Id { get; set; }
        public int FkCity_Id { get; set; }
        public Nullable<int> FKEnquiryType_Id { get; set; }
        public long FKUserCreated_Id { get; set; }
        public System.DateTime CreateDateTime { get; set; }
        public int Day { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public Nullable<int> FKBranch_Id { get; set; }
        public Nullable<bool> IsLinkedClinet { get; set; }
        public Nullable<bool> IsClosed { get; set; }
        public Nullable<System.DateTime> ClosedDateTime { get; set; }
        public bool IsWithBranch { get; set; }
        public string ClendarEventId { get; set; }
        public Nullable<bool> IsDepositPaymented { get; set; }
        public Nullable<long> FkClinet_Id { get; set; }
        public bool IsCreatedEvent { get; set; }
    }
}
