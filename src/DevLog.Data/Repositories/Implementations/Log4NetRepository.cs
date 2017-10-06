using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using DevLog.Data.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace DevLog.Data.Repositories.Implementations
{
    public class Log4NetRepository : ILog4NetRepository
    {
        public Log4NetRepository(IApplicationDbContext context)
        {
            Context = context;
        }

        public IApplicationDbContext Context { get; private set; }



        public IQueryable<Log4Net> All
        {
            get { return Context.Log4Net; }
        }

        public IQueryable<Log4Net> AllIncluding(params Expression<Func<Log4Net, object>>[] includeProperties)
        {
            return includeProperties.Aggregate<Expression<Func<Log4Net, object>>,
                IQueryable<Log4Net>>(Context.Log4Net, (current, includeProperty) => current.Include(includeProperty));
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }
 

        public Log4Net Find(int id)
        {
            return Context.Log4Net.Find(id);
        }

        
public void Save()
        {
            throw new NotImplementedException();
        }
        //{
        //    if (log4Net.ID == default(int))
        //    {
        //        // New entity
        //        Context.Log4Net.Add(log4Net);
        //    }
        //    else
        //    {
        //        // Existing entity
        //        _context.Entry(log4Net).State = EntityState.Modified;
        //    }
  
        public void Dispose()
        {
            Context.Dispose();
        }

        public void InsertOrUpdate(Log4Net log4Net)
        {
            throw new NotImplementedException();
        }
    }
}
