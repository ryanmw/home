using DevLog.Data.DbContextInfo;
using DevLog.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DevLog.Data.Repositories.Interfaces
{
    public interface IArticleRepository : IDisposable
    {
        IApplicationDbContext Context { get; }

        IQueryable<Article> All { get; }

        Article Find(int id);

        Article Find(string key);

        Article Create(Article article);

        void Delete(int id);

        List<Article> GetArticles(int pageNumber, int quantityPerPage, out int total);

        bool Update(Article model);


    }
}
