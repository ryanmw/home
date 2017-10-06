using DevLog.Data.Models;
using DevLog.Data.Repositories.Interfaces;
using DevLog.Web.Helpers;
using DevLog.Web.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace DevLog.Web.Controllers
{
    public class ArticlesController : Controller
    {
        const int PageSize = 10;
        private readonly IArticleRepository _articleRepository;
        private readonly ICommentRepository _commentRepository;
        private readonly IHttpContextAccessor _httpContextAccessor;
     
        public ArticlesController(
            IArticleRepository articleRepository, 
            ICommentRepository commentRepository,
            IHttpContextAccessor httpContextAccessor)
        {
            _articleRepository = articleRepository;
            _commentRepository = commentRepository;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpGet]
        public ViewResult Index()
        {
            return Page(1);
        }

        [HttpGet]
        public ViewResult Page(int pageNumber = 1)
        {
            int total;
            var articleList = _articleRepository.GetArticles(pageNumber, PageSize, out total);

            var model = new ArticlePageModel();
            
            foreach(var article in articleList)
            {
                model.Items.Add(new ArticlePageItemModel()
                {
                    PublishedOn = article.PublishedOn,
                    MetaDescription = article.MetaDescription,
                    Title = article.Title,
                    CommentCount = article.Comments.Count,
                    URLTo = SiteUtilityHelper.ArticleUrl(article.PublishedOn, article.Key)
                });
            }

            return View("Index", model);
        }

        [HttpGet]
        [Route("articles/{year}/{month}/{day}/{key}")]
        public ViewResult Display(string year, string month, string day, string key)
        {
            var article = _articleRepository.Find(key);

            var model = new ArticleDisplayModel()
            {
                Title = article.Title,
                ArticleId = article.ArticleId,
                Body = article.Body,
                Key = article.Key,
                MetaDescription = article.MetaDescription,
                PublishedOn = article.PublishedOn
            };

            foreach(var comment in article.Comments)
            {
                model.Comments.Add(new ArticleDisplayCommentItemModel()
                {
                    Author = comment.Author,
                    Body = comment.Body,
                    Email = comment.Email,
                    Url = comment.Url,
                    CreateDate = comment.CreateDate
                });
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult Comment(Comment model)
        {
            var article = _articleRepository.Find(model.ArticleId);

            model.IPAddress = SiteUtilityHelper.GetIpAddress(_httpContextAccessor);

            ModelState.Remove("IpAddress");

            TryUpdateModelAsync(model);

            if (ModelState.IsValid && SiteUtilityHelper.IsCaptchaValid(Request.Form))
            {
                _commentRepository.Create(model);
            }

            var path = SiteUtilityHelper.ArticleUrl(article.PublishedOn, article.Key) + "#comments";
            Response.Redirect(path);

            return new EmptyResult();
        }
    }
}
