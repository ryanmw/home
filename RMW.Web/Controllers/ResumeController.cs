using System.Web.Mvc;

namespace RMW.Web.Controllers
{
    public class ResumeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
    }
}
