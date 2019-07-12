﻿using BLL.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.ViewModels
{
    public class ResponseVM
    {
        public RequestTypeEnum RequestType { get; set; }
        public string Message { get; set; }
        public bool IsData { get; set; }
        public object Result { get; set; }
        public object DevMessage { get; set; }


        public ResponseVM(RequestTypeEnum requestType, string message, object data)
        {
            this.RequestType = requestType;
            this.Message = message;
            this.Result = data;
            this.IsData = data == null ? false : true;
        }

        public ResponseVM(RequestTypeEnum requestType, string message, Exception ex)
        {
            this.RequestType = requestType;
            this.Message = message;
            this.DevMessage = ex.Message;
        }
        public ResponseVM(RequestTypeEnum requestType, string message)
        {
            this.RequestType = requestType;
            this.Message = message;
        }
    }
}
