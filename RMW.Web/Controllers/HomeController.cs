﻿using System.Web.Mvc;

namespace RMW.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return RedirectToAction("Index", "Articles");
        }
    }
}
