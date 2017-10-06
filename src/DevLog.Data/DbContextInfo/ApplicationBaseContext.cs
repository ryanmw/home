using DevLog.Data.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace DevLog.Data.DbContextInfo
{
    public class ApplicationBaseContext<TContext> : IdentityDbContext<ApplicationUser> where TContext : DbContext
    {
        public ApplicationBaseContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }
    }
}
