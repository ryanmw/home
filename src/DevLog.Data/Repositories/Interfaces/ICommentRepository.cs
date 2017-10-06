using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using System;

namespace DevLog.Data.Repositories.Interfaces
{
    public interface ICommentRepository : IDisposable
    {
        IApplicationDbContext Context { get; }

        Comment Find(int id);

        Comment Create(Comment comment);

        void Delete(int id);
        
    }
}
