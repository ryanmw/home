
using DevLog.Data.Models.BaseModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using DevLog.Data.Models;

namespace DevLog.Data.DbContextInfo
{
    public class ApplicationDbContext : ApplicationBaseContext<ApplicationDbContext>, IApplicationDbContext
    {
        public DbSet<Article> Articles { get; set; }

        public DbSet<Comment> Comments { get; set; }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
     
        public DbSet<Log4Net> Log4Net { get; set; }

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }


        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Article>()
                    .HasIndex(b => b.Key)
                    .IsUnique();

            builder.Entity<Comment>()
                .HasOne(bc => bc.Article);

            base.OnModelCreating(builder);
        }
        public override int SaveChanges()
        {
            SetDates();

            return base.SaveChanges();
        }

        private void SetDates()
        {
            foreach (var entry in ChangeTracker.Entries()
                .Where(x => (x.Entity is StateInfo)
                            && x.State == EntityState.Added)
                .Select(x => x.Entity as StateInfo))
            {
                if (entry.CreateDate == DateTime.MinValue) entry.CreateDate = DateTime.UtcNow;
            }

            foreach (var entry in ChangeTracker.Entries()
                .Where(x => (x.Entity is CreatedStateInfo)
                            && x.State == EntityState.Added)
                .Select(x => x.Entity as CreatedStateInfo))
            {
                if (entry.CreateDate == DateTime.MinValue) entry.CreateDate = DateTime.UtcNow;
            }

            foreach (var entry in ChangeTracker.Entries()
                .Where(x => x.Entity is StateInfo && x.State == EntityState.Modified)
                .Select(x => x.Entity as StateInfo))
            {
                entry.UpdateDate = DateTime.UtcNow;
            }
        }

        public override Task<int> SaveChangesAsync(
            CancellationToken cancellationToken = default(CancellationToken))
        {
            SetDates();

            return base.SaveChangesAsync(cancellationToken);
        }
        
    }
}
