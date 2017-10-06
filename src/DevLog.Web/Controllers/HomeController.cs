
using Microsoft.AspNetCore.Mvc;

namespace DevLog.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return RedirectToAction("Index", "articles");
        }
    }
}
