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
    
    public partial class Packages_SelectByPaging_Result
    {
        public int Id { get; set; }
        public long FkWordName_Id { get; set; }
        public bool IsAllowPrintNames { get; set; }
        public long FkWordDescription_Id { get; set; }
        public int FKAlbumType_Id { get; set; }
        public string NameAr { get; set; }
        public string NameEn { get; set; }
        public string DescriptionAr { get; set; }
        public string DescriptionEn { get; set; }
    }
}
