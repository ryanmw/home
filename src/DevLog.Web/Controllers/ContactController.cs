
using Microsoft.AspNetCore.Mvc;

namespace DevLog.Web.Controllers
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
