using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using RMW.DataLayer;

namespace RMW.Models
{ 
    public class Log4NetRepository : ILog4NetRepository
    {
        RMWContext context = new RMWContext();

        public IQueryable<Log4Net> All
        {
            get { return context.Log4Net; }
        }

        public IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties)
        {
            IQueryable<Log4Net> query = context.Log4Net;
            foreach (var includeProperty in includeProperties) {
                query = query.Include(includeProperty);
            }
            return query;
        }

        public Log4Net Find(int id)
        {
            return context.Log4Net.Find(id);
        }

        public void InsertOrUpdate(Log4Net log4net)
        {
            if (log4net.ID == default(int)) {
                // New entity
                context.Log4Net.Add(log4net);
            } else {
                // Existing entity
                context.Entry(log4net).State = EntityState.Modified;
            }
        }

        public void Delete(int id)
        {
            var log4net = context.Log4Net.Find(id);
            context.Log4Net.Remove(log4net);
        }

        public void Save()
        {
            context.SaveChanges();
        }

        public void Dispose() 
        {
            context.Dispose();
        }
    }

    public interface ILog4NetRepository : IDisposable
    {
        IQueryable<Log4Net> All { get; }
        IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties);
        Log4Net Find(int id);
        void InsertOrUpdate(Log4Net log4net);
        void Delete(int id);
        void Save();
    }
}