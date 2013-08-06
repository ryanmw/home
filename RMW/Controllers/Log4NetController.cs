using System.Web.Mvc;
using RMW.Models;

namespace RMW.Controllers
{   
    public class Log4NetController : Controller
    {
		private readonly ILog4NetRepository _log4NetRepository;

		// If you are using Dependency Injection, you can delete the following constructor
        public Log4NetController() : this(new Log4NetRepository())
        {
        }

        public Log4NetController(ILog4NetRepository log4NetRepository)
        {
			this._log4NetRepository = log4NetRepository;
        }

        //
        // GET: /Log4Net/

        public ViewResult Index()
        {
            return View(_log4NetRepository.All);
        }

        //
        // GET: /Log4Net/Details/5

        public ViewResult Details(int id)
        {
            return View(_log4NetRepository.Find(id));
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
            if (!ModelState.IsValid)
            {
                return View();
            }
            _log4NetRepository.InsertOrUpdate(log4net);
            _log4NetRepository.Save();
            return RedirectToAction("Index");
        }

        //
        // GET: /Log4Net/Edit/5
 
        public ActionResult Edit(int id)
        {
             return View(_log4NetRepository.Find(id));
        }

        //
        // POST: /Log4Net/Edit/5

        [HttpPost]
        public ActionResult Edit(Log4Net log4net)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }
            _log4NetRepository.InsertOrUpdate(log4net);
            _log4NetRepository.Save();
            return RedirectToAction("Index");
        }

        //
        // GET: /Log4Net/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View(_log4NetRepository.Find(id));
        }

        //
        // POST: /Log4Net/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            _log4NetRepository.Delete(id);
            _log4NetRepository.Save();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) {
                _log4NetRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

