﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Enums;

namespace BLL.ViewModels
{
    public class UserCookieVM
    {
        public long Id { get;   set; }
        public string ReturnUrl { get;   set; }
        public string Email { get; set; }

        public bool IsActiveEmail { get;   set; }
        public bool _IsRemmeberMe { get;   set; }
        public LanguageEnum _Language { get;   set; }
        public int AccountTypeId { get;   set; }
        public bool IsClinet => this.AccountTypeId == (int)AccountTypeEnum.Clinet;
        public string UserName { get;   set; }
        public int BranchId { get; set; }
    }
}
