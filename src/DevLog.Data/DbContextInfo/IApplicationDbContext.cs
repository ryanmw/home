using DevLog.Data.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace DevLog.Data.DbContextInfo
{
    public interface IApplicationDbContext : IDisposable
    {
        int SaveChanges();

         DbSet<Article> Articles { get; set; }

         DbSet<Comment> Comments { get; set; }

         DbSet<ApplicationUser> ApplicationUsers { get; set; }

        //    DbSet<Role> Roles { get; set; }
 

        DbSet<Log4Net> Log4Net { get; set; }

        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default(CancellationToken));
    }
}
