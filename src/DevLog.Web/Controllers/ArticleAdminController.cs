using DevLog.Data.Models;
using DevLog.Data.Repositories.Interfaces;
using DevLog.Web.Helpers;
using DevLog.Web.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;

namespace DevLog.Web.Controllers
{
    [Authorize]
    public class ArticleAdminController : Controller
    {
        const int PageSize = 10;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IArticleRepository _articleRepository;
        private readonly ICommentRepository _commentRepository;

        public ArticleAdminController(
          UserManager<ApplicationUser> userManager,
          SignInManager<ApplicationUser> signInManager,
          RoleManager<IdentityRole> roleManager,
          IArticleRepository articleRepository,
          ICommentRepository commentRepository)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _articleRepository = articleRepository;
            _commentRepository = commentRepository;
        }
        
    
        [HttpGet]
        public IActionResult Index(int currentPage = 1)
        {
            int total;
            int pageNumber = 1;

            if (!int.TryParse(Request.Query["page"], out currentPage)) currentPage = 1;

            var articleList = _articleRepository.GetArticles(pageNumber, PageSize, out total);

            var model = new ArticlePageModel();

            foreach (var article in articleList)
            {
                model.Items.Add(new ArticlePageItemModel()
                {
                    ArticleId = article.ArticleId,
                    PublishedOn = article.PublishedOn,
                    MetaDescription = article.MetaDescription,
                    Title = article.Title,
                    URLTo = SiteUtilityHelper.ArticleUrl(article.PublishedOn, article.Key)
                });
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View(new EditArticleModel()
            {
                PublishedOn = DateTime.UtcNow
            });
        }

        [HttpPost]
        public ActionResult Create(EditArticleModel article)
        {
            if (!ModelState.IsValid)
            {
                return View(article);
            }

            _articleRepository.Create(new Article()
            {
                Body = article.Body,
                Key = SiteUtilityHelper.WebSafeMaker(article.Title),
                Title = article.Title.Trim(),
                MetaDescription = article.MetaDescription.Trim(),
                PublishedOn = article.PublishedOn
            });

            return RedirectToAction(nameof(Index));

        }

        public ActionResult Edit(int id)
        {
            var article = _articleRepository.Find(id);

            var model = new EditArticleModel()
            {
                ArticleId = article.ArticleId,
                Body = article.Body,
                MetaDescription = article.MetaDescription,
                PublishedOn = article.PublishedOn,
                Title = article.Title
            };

            foreach(var comment in article.Comments)
            {
                model.Comments.Add(new EditArticleCommentItemModel()
                {
                    CommentDetails = comment.Body,
                    CommentId = comment.CommentId
                });
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult Edit(EditArticleModel article)
        {
            if (!ModelState.IsValid)
            {
                return View(article);
            }

            var currentArticle = _articleRepository.Find(article.ArticleId);

            currentArticle.Key = SiteUtilityHelper.WebSafeMaker(article.Title);
            currentArticle.PublishedOn = article.PublishedOn;
            currentArticle.Body = article.Body;
            currentArticle.Title = article.Title.Trim();
            currentArticle.MetaDescription = article.MetaDescription.Trim();

            _articleRepository.Update(currentArticle);

            return RedirectToAction(nameof(Index));
        }

        public ActionResult Delete(int id)
        {
            return View(_articleRepository.Find(id));
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteArticleConfirmed(int id)
        {
            _articleRepository.Delete(id);

            return RedirectToAction(nameof(Index));
        }

        [HttpGet]
        public ActionResult DeleteComment(int commentId)
        {
            _commentRepository.Delete(commentId);

            return RedirectToAction(nameof(Index));
        } 
    }
}
