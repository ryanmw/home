using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RMW.Models;

namespace RMW.Controllers
{   
    public class CommentsController : Controller
    {
		private readonly IArticleRepository articleRepository;
		private readonly ICommentRepository commentRepository;

		// If you are using Dependency Injection, you can delete the following constructor
        public CommentsController() : this(new ArticleRepository(), new CommentRepository())
        {
        }

        public CommentsController(IArticleRepository articleRepository, ICommentRepository commentRepository)
        {
			this.articleRepository = articleRepository;
			this.commentRepository = commentRepository;
        }

        //
        // GET: /Comments/

        public ViewResult Index()
        {
            return View(commentRepository.All);
        }

        //
        // GET: /Comments/Details/5

        public ViewResult Details(int id)
        {
            return View(commentRepository.Find(id));
        }

        //
        // GET: /Comments/Create

        public ActionResult Create()
        {
			ViewBag.PossibleArticles = articleRepository.All;
            return View();
        } 

        //
        // POST: /Comments/Create

        [HttpPost]
        public ActionResult Create(Comment comment)
        {
            if (ModelState.IsValid) {
                commentRepository.InsertOrUpdate(comment);
                commentRepository.Save();
                return RedirectToAction("Index");
            } else {
				ViewBag.PossibleArticles = articleRepository.All;
				return View();
			}
        }
        
        //
        // GET: /Comments/Edit/5
 
        public ActionResult Edit(int id)
        {
			ViewBag.PossibleArticles = articleRepository.All;
             return View(commentRepository.Find(id));
        }

        //
        // POST: /Comments/Edit/5

        [HttpPost]
        public ActionResult Edit(Comment comment)
        {
            if (ModelState.IsValid) {
                commentRepository.InsertOrUpdate(comment);
                commentRepository.Save();
                return RedirectToAction("Index");
            } else {
				ViewBag.PossibleArticles = articleRepository.All;
				return View();
			}
        }

        //
        // GET: /Comments/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View(commentRepository.Find(id));
        }

        //
        // POST: /Comments/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            commentRepository.Delete(id);
            commentRepository.Save();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) {
                articleRepository.Dispose();
                commentRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

