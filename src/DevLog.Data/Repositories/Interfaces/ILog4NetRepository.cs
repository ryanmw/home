using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using System;
using System.Linq;
using System.Linq.Expressions;

namespace DevLog.Data.Repositories.Interfaces
{
    public interface ILog4NetRepository : IDisposable
    {
        IApplicationDbContext Context { get; }

        IQueryable<Log4Net> All { get; }
        IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties);
        Log4Net Find(int id);
        void InsertOrUpdate(Log4Net log4Net);
        void Delete(int id);
        void Save();
    }
}
