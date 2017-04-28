using System.Web.Mvc;

namespace RMW.Web.Controllers
{
    public class ContactController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
    }
}
