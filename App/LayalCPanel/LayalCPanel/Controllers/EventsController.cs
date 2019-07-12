﻿using BLL.BLL;
using BLL.Enums;
using BLL.ViewModels;
using Resources;
using UI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UI.Controllers
{
    [Authorize]
    public class EventsController : BasicController
    {
        EventsBLL EventsBLL = new EventsBLL();

        [PagePrivilege(PagesEnum.Events, true, true, true, true)]
        public ActionResult Index()
        {
            return View();
        }
        [PagePrivilege(PagesEnum.Events, false, false, true, true)]
        public ActionResult AddAndUpdate()
        {
            return View();
        }
        [PagePrivilege(PagesEnum.Events, false, false, true, true)]
        public ActionResult DistributionOfWork()
        {
            return View();
        }
        
        public ActionResult EventsInformation()
        {
            return View();
        }

        public ActionResult GetItems(bool? isForFilter)
        {
            return Json(new ResponseVM(RequestTypeEnum.Success, Token.Success, new
            {
                Packages = FillItems.GetPackages(),
                PrintNameTypes = FillItems.GetPrintNameTypes(),
                Branches= isForFilter.HasValue&&isForFilter.Value?FillItems.GetBranches():null

            }), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetEvents(EventVM even)
        {
            return Json(EventsBLL.GetEvents(even), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetEvent(long id)
        {
            return Json(EventsBLL.SelectById(id), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetEventInformation(long id)
        {
            return Json(EventsBLL.SelectInformation(id), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SaveChange(EventVM enquiryType)
        {
            return Json(EventsBLL.SaveChange(enquiryType), JsonRequestBehavior.AllowGet);
        }
    }//end class
}