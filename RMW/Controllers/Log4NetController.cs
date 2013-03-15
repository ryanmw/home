using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RMW.Models;

namespace RMW.Controllers
{   
    public class Log4NetController : Controller
    {
		private readonly ILog4NetRepository log4netRepository;

		// If you are using Dependency Injection, you can delete the following constructor
        public Log4NetController() : this(new Log4NetRepository())
        {
        }

        public Log4NetController(ILog4NetRepository log4netRepository)
        {
			this.log4netRepository = log4netRepository;
        }

        //
        // GET: /Log4Net/

        public ViewResult Index()
        {
            return View(log4netRepository.All);
        }

        //
        // GET: /Log4Net/Details/5

        public ViewResult Details(int id)
        {
            return View(log4netRepository.Find(id));
        }

        //
        // GET: /Log4Net/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Log4Net/Create

        [HttpPost]
        public ActionResult Create(Log4Net log4net)
        {
            if (ModelState.IsValid) {
                log4netRepository.InsertOrUpdate(log4net);
                log4netRepository.Save();
                return RedirectToAction("Index");
            } else {
				return View();
			}
        }
        
        //
        // GET: /Log4Net/Edit/5
 
        public ActionResult Edit(int id)
        {
             return View(log4netRepository.Find(id));
        }

        //
        // POST: /Log4Net/Edit/5

        [HttpPost]
        public ActionResult Edit(Log4Net log4net)
        {
            if (ModelState.IsValid) {
                log4netRepository.InsertOrUpdate(log4net);
                log4netRepository.Save();
                return RedirectToAction("Index");
            } else {
				return View();
			}
        }

        //
        // GET: /Log4Net/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View(log4netRepository.Find(id));
        }

        //
        // POST: /Log4Net/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            log4netRepository.Delete(id);
            log4netRepository.Save();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) {
                log4netRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

