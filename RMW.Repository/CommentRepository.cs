using System;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using RMW.Models;

namespace RMW.Repository
{
    public class CommentRepository : ICommentRepository
    {
        readonly RMWContext _context = new RMWContext();

        public IQueryable<Comment> All
        {
            get { return _context.Comments; }
        }

        public IQueryable<Comment> AllIncluding(params Expression<Func<Comment, object>>[] includeProperties)
        {
            IQueryable<Comment> query = _context.Comments;
            foreach (var includeProperty in includeProperties)
            {
                query = query.Include(includeProperty);
            }
            return query;
        }

        public Comment Find(int id)
        {
            return _context.Comments.Find(id);
        }

        public void InsertOrUpdate(Comment comment)
        {
            if (comment.Id == default(int))
            {
                // New entity
                _context.Comments.Add(comment);
            }
            else
            {
                // Existing entity
                _context.Entry(comment).State = EntityState.Modified;
            }
        }

        public void Delete(int id)
        {
            var comment = _context.Comments.Find(id);
            _context.Comments.Remove(comment);
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }

    public interface ICommentRepository : IDisposable
    {
        IQueryable<Comment> All { get; }
        IQueryable<Comment> AllIncluding(params Expression<Func<Comment, object>>[] includeProperties);
        Comment Find(int id);
        void InsertOrUpdate(Comment comment);
        void Delete(int id);
        void Save();
    }
}