using System;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using log4net;
using RMW.Models;
using RMW.Operational;
using RMW.Repository;

namespace RMW.Web.Controllers
{

    public class ArticlesController : Controller
    {
        const int PageSize = 10;

        public IArticleRepository _articleRepository;

        private readonly ICommentRepository _commentRepository;

        private readonly HttpContextBase _httpContext;

        private static readonly ILog Log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        // If you are using Dependency Injection, you can delete the following constructor
        public ArticlesController()
            : this(new ArticleRepository(), 
            new CommentRepository(),
            new HttpContextWrapper(System.Web.HttpContext.Current))
        {
        }

        public ArticlesController(
            IArticleRepository articleRepository, 
            ICommentRepository commentRepository,
            HttpContextBase baseContext)
        {
            this._httpContext        = baseContext;
            this._articleRepository = articleRepository;
            this._commentRepository = commentRepository;
            log4net.Config.XmlConfigurator.Configure();
        }


        [HttpGet]
        public ViewResult Index()
        {
            var currentPage = 1;

            ViewBag.CurrentPage = currentPage;

            var articleList = _articleRepository.GetsArticles(currentPage, PageSize);
 
            return View(articleList);
        }

        [HttpGet]
        public ViewResult Page(int pageNumber = 1)
        {
            var articleList = _articleRepository.GetsArticles(pageNumber, PageSize);

            ViewBag.CurrentPage = pageNumber;

            return View("Index", articleList);
        }

        [Authorize]
        public ViewResult Admin()
        {
            var currentPage = 1;

            if (!int.TryParse(Request.QueryString["page"], out currentPage)) currentPage = 1;

            var articleList = _articleRepository.GetsArticles(currentPage, PageSize);

            return View(articleList);
        }

        public ViewResult Details(int id)
        {
            return View(_articleRepository.Find(id));
        }

        [HttpGet]
        public ViewResult Display(string yyyy, string mm, string dd, string key)
        {
            return View(_articleRepository.Find(key));
        }

        [HttpPost]
        public ActionResult Comment(Comment model)
        {
            var article = _articleRepository.Find(model.ArticleId);

            model.IPAddress = Request.UserHostAddress;
            model.CreatedOn = DateTime.UtcNow;

            ModelState.Remove("CreatedOn");
            ModelState.Remove("IpAddress");

            TryUpdateModel(model);

            if (ModelState.IsValid && Utilities.IsCaptchaValid(Request.Form))
            {
                _commentRepository.InsertOrUpdate(model);

                _commentRepository.Save();
            }

            Response.Redirect("~/" + article.URLTo + "#comments");
            return new EmptyResult();
        }

        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(Article article)
        {
            if (!ModelState.IsValid)
            {
                return View(article);
            }

            article.Key = Utilities.WebSafeMaker(article.Key);

            article.Title = article.Title.Trim();
            _articleRepository.InsertOrUpdate(article);
            _articleRepository.Save();
            return RedirectToAction("Admin");
        }

        [Authorize]
        public ActionResult Edit(int id)
        {
            return View(_articleRepository.Find(id));
        }

        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Article article)
        {
            if (!ModelState.IsValid)
            {
                return View(article);
            }

            var currentArticle = _articleRepository.Find(article.Id);

            currentArticle.Key = Utilities.WebSafeMaker(article.Key);
            currentArticle.UpdatedOn = DateTime.UtcNow;
            currentArticle.CreatedOn = article.CreatedOn;
            currentArticle.Body = article.Body;
            currentArticle.Title = article.Title.Trim();
            currentArticle.MetaDescription = article.MetaDescription;

            _articleRepository.InsertOrUpdate(currentArticle);

            _articleRepository.Save();
            return RedirectToAction("Admin");
        }

        [Authorize]
        public ActionResult Delete(int id)
        {
            return View(_articleRepository.Find(id));
        }

        [Authorize]
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            _articleRepository.Delete(id);
            _articleRepository.Save();

            return RedirectToAction("Admin");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _articleRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
