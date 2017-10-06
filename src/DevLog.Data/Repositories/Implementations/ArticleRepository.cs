using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using DevLog.Data.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace DevLog.Data.Repositories.Implementations
{

    public class ArticleRepository : IArticleRepository
    {
        public ArticleRepository(IApplicationDbContext context)
        {
            Context = context;
        }

        public IApplicationDbContext Context { get; private set; }


        public IQueryable<Article> All
        {
            get { return Context.Articles; }
        }


        public Article Find(int id)
        {
            return Context.Articles.Include(i => i.Comments).FirstOrDefault(x => x.ArticleId == id);
        }
 
        public void Delete(int id)
        {
            var article = Context.Articles.Find(id);
            Context.Articles.Remove(article);
        }

        public void Dispose()
        {
            Context.Dispose();
        }


        public Article Find(string key)
        {
            try
            {
                return Context.Articles.Include(i => i.Comments).First(e => e.Key == key);
            }
            catch (Exception ex)
            {
                throw new Exception("DB error", ex.InnerException);
            }
        }

        public List<Article> GetArticles(int pageNumber, int quantityPerPage, out int total)
        {
            var now = DateTime.UtcNow;

            try
            {
                var model = Context.Articles
                                   .Where(x => x.PublishedOn   < now)
                                   .Include(x => x.Comments)
                                   .OrderByDescending(blog => blog.PublishedOn)
                                   .Skip(quantityPerPage * (pageNumber - 1))
                                   .Take(quantityPerPage)
                                   .ToList();

                total = Context.Articles.Where(x => x.PublishedOn < now).Count();

                return model;
            }
            catch (Exception ex)
            {
                //log.Fatal(ex);

                throw new Exception("DB error", ex.InnerException);
            }
        }

        public Article Create(Article model)
        {
            try
            {
                Context.Articles.Add(model);
                Context.SaveChanges();

                return model;
            }
            catch (Exception ex)
            {
                
                throw new Exception("DB error", ex.InnerException);
            }
        }


        public bool Update(Article model)
        {
            try
            {
                Context.Articles.Update(model);
                Context.SaveChanges();

                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("DB error", ex.InnerException);

            }
        }
    }
}
