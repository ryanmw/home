
using Microsoft.AspNetCore.Mvc;

namespace DevLog.Web.Controllers
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
