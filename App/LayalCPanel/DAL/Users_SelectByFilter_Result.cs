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
    
    public partial class Users_SelectByFilter_Result
    {
        public long Id { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string PhoneNo { get; set; }
        public string Address { get; set; }
        public string Password { get; set; }
        public string ActiveCode { get; set; }
        public int FKAccountType_Id { get; set; }
        public Nullable<int> FkCountry_Id { get; set; }
        public Nullable<int> FkCity_Id { get; set; }
        public int FKLanguage_Id { get; set; }
        public System.DateTime CreateDateTime { get; set; }
        public Nullable<int> FKPranch_Id { get; set; }
        public bool IsActiveEmail { get; set; }
        public Nullable<System.DateTime> DateOfBirth { get; set; }
        public string AccountTypeNameAr { get; set; }
        public string AccountTypeNameEn { get; set; }
        public string CountryNameAr { get; set; }
        public string CountryNameEn { get; set; }
        public string CityNameAr { get; set; }
        public string CityNameEn { get; set; }
    }
}
