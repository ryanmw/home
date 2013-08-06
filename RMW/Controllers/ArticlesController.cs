using System;
using System.Web.Mvc;
using RMW.Models;
using RMW.Operational;

namespace RMW.Controllers
{

    public class ArticlesController : Controller
    {
        const int PageSize = 10;

        private readonly IArticleRepository _articleRepository;

        private readonly ICommentRepository _commentRepository;

        // If you are using Dependency Injection, you can delete the following constructor
        public ArticlesController()
            : this(new ArticleRepository(), new CommentRepository())
        {
        }

        public ArticlesController(IArticleRepository articleRepository, ICommentRepository commentRepository)
        {
            this._articleRepository = articleRepository;
            this._commentRepository = commentRepository;
        }

        //
        // GET: /Articles/

        public ViewResult Index()
        {
            var currentPage = 1;

            if (!int.TryParse(Request.QueryString["page"], out currentPage)) currentPage = 1;

            var articleList = _articleRepository.GetsArticles(currentPage, PageSize);
 
            return View(articleList);
        }

        [Authorize]
        public ViewResult Admin()
        {
            var currentPage = 1;

            if (!int.TryParse(Request.QueryString["page"], out currentPage)) currentPage = 1;

            var articleList = _articleRepository.GetsArticles(currentPage, PageSize);

            return View(articleList);
        }

        //
        // GET: /Articles/Details/5

        public ViewResult Details(int id)
        {
            return View(_articleRepository.Find(id));
        }

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

        //
        // GET: /Articles/Create
        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Articles/Create
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

        //
        // GET: /Articles/Edit/5
        [Authorize]
        public ActionResult Edit(int id)
        {
            return View(_articleRepository.Find(id));
        }

        //
        // POST: /Articles/Edit/5
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

        //
        // GET: /Articles/Delete/5
        [Authorize]
        public ActionResult Delete(int id)
        {
            return View(_articleRepository.Find(id));
        }

        //
        // POST: /Articles/Delete/5
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
