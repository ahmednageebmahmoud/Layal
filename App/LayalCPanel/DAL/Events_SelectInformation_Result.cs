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
    
    public partial class Events_SelectInformation_Result
    {
        public long Id { get; set; }
        public Nullable<bool> IsClinetCustomLogo { get; set; }
        public Nullable<bool> IsLogoAr { get; set; }
        public string LogoFilePath { get; set; }
        public Nullable<bool> IsNamesAr { get; set; }
        public string NameGroom { get; set; }
        public string NameBride { get; set; }
        public Nullable<int> FKPrintNameType_Id { get; set; }
        public System.DateTime EventDateTime { get; set; }
        public System.DateTime CreateDateTime { get; set; }
        public Nullable<long> FkEnquiryForm_Id { get; set; }
        public int FKPackage_Id { get; set; }
        public long FKClinet_Id { get; set; }
        public string Notes { get; set; }
        public long FKUserCreaed_Id { get; set; }
        public int FKBranch_Id { get; set; }
        public bool IsActive { get; set; }
        public bool IsCanNotUpdate { get; set; }
        public string ClendarEventId { get; set; }
        public string EnquiryName { get; set; }
        public Nullable<bool> EnquiryIsClosed { get; set; }
        public string Package_NameAr { get; set; }
        public string Package_NameEn { get; set; }
        public bool Package_IsAllowPrintNames { get; set; }
        public string PrintNameType_NameAr { get; set; }
        public string PrintNameType_NameEn { get; set; }
        public string Branch_NameAr { get; set; }
        public string Branch_NameEn { get; set; }
        public string Clinet_UserName { get; set; }
        public string UserCreated_UserName { get; set; }
    }
}
