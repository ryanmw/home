using System;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace RMW.Models
{ 
    /// <summary>
    /// Provides a repository log messages
    /// </summary>
    public class Log4NetRepository : ILog4NetRepository
    {
        readonly RMWContext _context = new RMWContext();

        public IQueryable<Log4Net> All
        {
            get { return _context.Log4Net; }
        }

        public IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties)
        {
            return includeProperties.Aggregate<Expression<Func<Log4Net, object>>,
                IQueryable<Log4Net>>(_context.Log4Net, (current, includeProperty) => current.Include(includeProperty));
        }

        public Log4Net Find(int id)
        {
            return _context.Log4Net.Find(id);
        }

        public void InsertOrUpdate(Log4Net log4Net)
        {
            if (log4Net.ID == default(int)) {
                // New entity
                _context.Log4Net.Add(log4Net);
            } else {
                // Existing entity
                _context.Entry(log4Net).State = EntityState.Modified;
            }
        }

        public void Delete(int id)
        {
            var log4Net = _context.Log4Net.Find(id);
            _context.Log4Net.Remove(log4Net);
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

    public interface ILog4NetRepository : IDisposable
    {
        IQueryable<Log4Net> All { get; }
        IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties);
        Log4Net Find(int id);
        void InsertOrUpdate(Log4Net log4Net);
        void Delete(int id);
        void Save();
    }
}