using System.Web.Mvc;
using RMW.Models;

namespace RMW.Controllers
{   
    public class CommentsController : Controller
    {
		private readonly IArticleRepository _articleRepository;
		private readonly ICommentRepository _commentRepository;

		// If you are using Dependency Injection, you can delete the following constructor
        public CommentsController() : this(new ArticleRepository(), new CommentRepository())
        {
           
        }

        public CommentsController(IArticleRepository articleRepository, ICommentRepository commentRepository)
        {
			this._articleRepository = articleRepository;
			this._commentRepository = commentRepository;
        }

        //
        // GET: /Comments/

        public ViewResult Index()
        {
            return View(_commentRepository.All);
        }

        //
        // GET: /Comments/Details/5

        public ViewResult Details(int id)
        {
            return View(_commentRepository.Find(id));
        }

        //
        // GET: /Comments/Create

        public ActionResult Create()
        {
			ViewBag.PossibleArticles = _articleRepository.All;
            return View();
        } 

        //
        // POST: /Comments/Create

        [HttpPost]
        public ActionResult Create(Comment comment)
        {
            if (ModelState.IsValid) {
                _commentRepository.InsertOrUpdate(comment);
                _commentRepository.Save();
                return RedirectToAction("Index");
            } else {
				ViewBag.PossibleArticles = _articleRepository.All;
				return View();
			}
        }
        
        //
        // GET: /Comments/Edit/5
 
        public ActionResult Edit(int id)
        {
			ViewBag.PossibleArticles = _articleRepository.All;
             return View(_commentRepository.Find(id));
        }

        //
        // POST: /Comments/Edit/5

        [HttpPost]
        public ActionResult Edit(Comment comment)
        {
            if (ModelState.IsValid) {
                _commentRepository.InsertOrUpdate(comment);
                _commentRepository.Save();
                return RedirectToAction("Index");
            } else {
				ViewBag.PossibleArticles = _articleRepository.All;
				return View();
			}
        }

        //
        // GET: /Comments/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View(_commentRepository.Find(id));
        }

        //
        // POST: /Comments/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            _commentRepository.Delete(id);
            _commentRepository.Save();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) {
                _articleRepository.Dispose();
                _commentRepository.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

