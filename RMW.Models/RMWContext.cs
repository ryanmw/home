using System.Data.Entity;

namespace RMW.Models
{
    public class RMWContext : DbContext
    {
        public DbSet<Article> Articles { get; set; }

        public DbSet<Comment> Comments { get; set; }

        public DbSet<User> Users { get; set; }

        public DbSet<Role> Roles { get; set; }

        static RMWContext()
        {
            Database.SetInitializer<RMWContext>(null);
        }

        public DbSet<Log4Net> Log4Net { get; set; }
    }
}