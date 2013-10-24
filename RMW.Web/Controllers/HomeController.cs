using System.Web.Mvc;

namespace RMW.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return RedirectToAction("Index", "Articles");
        }

        public ActionResult Portfolio()
        {
            return View();
        }

        public ActionResult Resume()
        {
            return View();
        }

        public ActionResult About()
        {

            return View();
        }

        public ViewResult Contact()
        {
            return View();
        }
    }
}
