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
    
    public partial class Phot_ProductsOptions_SelectByProductId_Result
    {
        public long Id { get; set; }
        public int FKStaticField_Id { get; set; }
        public long FKProduct_Id { get; set; }
        public string NameAr { get; set; }
        public string NameEn { get; set; }
        public string ValueAr { get; set; }
        public string ValueEn { get; set; }
        public Nullable<long> OptionItemId { get; set; }
        public decimal Price { get; set; }
        public Nullable<long> FKWord_Value_Id { get; set; }
    }
}