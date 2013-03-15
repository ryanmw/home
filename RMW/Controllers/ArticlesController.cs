using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RMW.Models;
using RMW.Operational;

namespace RMW.Controllers
{

    public class ArticlesController : Controller
    {
        const int pageSize = 10;

        private readonly IArticleRepository articleRepository;

        private readonly ICommentRepository commentRepository;

        // If you are using Dependency Injection, you can delete the following constructor
        public ArticlesController()
            : this(new ArticleRepository(), new CommentRepository())
        {
        }

        public ArticlesController(IArticleRepository articleRepository, ICommentRepository commentRepository)
        {
            this.articleRepository = articleRepository;
            this.commentRepository = commentRepository;
        }

        //
        // GET: /Articles/

        public ViewResult Index()
        {
            int currentPage = 1;

            if (!int.TryParse(Request.QueryString["page"], out currentPage)) currentPage = 1;

            PagedResult<Article> articleList = articleRepository.GetsArticles(currentPage, pageSize);

            return View(articleList);
        }

        [Authorize]
        public ViewResult Admin()
        {
            int currentPage = 1;

            if (!int.TryParse(Request.QueryString["page"], out currentPage)) currentPage = 1;

            PagedResult<Article> articleList = articleRepository.GetsArticles(currentPage, pageSize);

            return View(articleList);
        }

        //
        // GET: /Articles/Details/5

        public ViewResult Details(int id)
        {
            return View(articleRepository.Find(id));
        }

        public ViewResult Display( string yyyy, string mm, string dd, string key)
        {
            return View(articleRepository.Find(key));
        }


        [HttpPost]
        public ActionResult Comment(Comment model)
        {
            Article article = articleRepository.Find(model.ArticleId);

            model.IPAddress = Request.UserHostAddress;
            model.CreatedOn = DateTime.UtcNow;

            ModelState.Remove("CreatedOn");
            ModelState.Remove("IpAddress");

            TryUpdateModel(model);

            if (ModelState.IsValid && Utilities.IsCaptchaValid(Request.Form))
            {
                commentRepository.InsertOrUpdate(model);

                commentRepository.Save();
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
            if (ModelState.IsValid)
            {
                article.Key = Utilities.WebSafeMaker(article.Key);
                
                article.Title = article.Title.Trim();
                articleRepository.InsertOrUpdate(article);
                articleRepository.Save();
                return RedirectToAction("Admin");
            }
            else
            {
                return View(article);
            }
        }

        //
        // GET: /Articles/Edit/5
        [Authorize]
        public ActionResult Edit(int id)
        {
            return View(articleRepository.Find(id));
        }

        //
        // POST: /Articles/Edit/5
        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Article article)
        {
            if (ModelState.IsValid)
            {
                Article currentArticle = articleRepository.Find(article.Id);

                currentArticle.Key = Utilities.WebSafeMaker(article.Key);
                currentArticle.UpdatedOn = DateTime.UtcNow;
                currentArticle.CreatedOn = article.CreatedOn;
                currentArticle.Body = article.Body;
                currentArticle.Title = article.Title.Trim();
                currentArticle.MetaDescription = article.MetaDescription;

                articleRepository.InsertOrUpdate(currentArticle);

                articleRepository.Save();
                return RedirectToAction("Admin");
            }
            else
            {
                return View(article);
            }
        }

        //
        // GET: /Articles/Delete/5
        [Authorize]
        public ActionResult Delete(int id)
        {
            return View(articleRepository.Find(id));
        }

        //
        // POST: /Articles/Delete/5
        [Authorize]
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            articleRepository.Delete(id);
            articleRepository.Save();

            return RedirectToAction("Admin");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                articleRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

