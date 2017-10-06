using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using DevLog.Data.Repositories.Interfaces;
using System;
using System.Linq;

namespace DevLog.Data.Repositories.Implementations
{
    public class CommentRepository : ICommentRepository
    {
        public CommentRepository(IApplicationDbContext context)
        {
            Context = context;
        }

        public IApplicationDbContext Context { get; private set; }

        public Comment Find(int id)
        {
            return Context.Comments.Find(id);
        }

        public void Delete(int id)
        {
            try
            {
                var entry = Context.Comments
                              .FirstOrDefault(x => x.CommentId == id);

                Context.Comments.Remove(entry);
                Context.SaveChanges();

                return;
            }
            catch (Exception ex)
            {
                throw new Exception("DB error", ex.InnerException);

            }
        }

        public void Dispose()
        {
            Context.Dispose();
        }

        public Comment Create(Comment comment)
        {
            try
            {
                Context.Comments.Add(comment);
                Context.SaveChanges();

                return comment;
            }
            catch (Exception ex)
            {
                throw new Exception("DB error", ex.InnerException);
            }
        }
    }
}
