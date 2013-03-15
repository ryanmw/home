using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using RMW.Models;

namespace RMW.DataLayer
{
 


    public class RMWContext : DbContext
    {
        public DbSet<RMW.Models.Article> Articles { get; set; }

        public DbSet<RMW.Models.Comment> Comments { get; set; }

       // public DbSet<UserProfile> UserProfiles { get; set; }

        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
 

        static RMWContext()
        {
            Database.SetInitializer<RMWContext>(null);
        }

        public DbSet<RMW.Models.Log4Net> Log4Net { get; set; }

        //protected RMWContext()
        //    : base("name=RMWContext")
        //{

        //}
    }
 

    //public class BaseContext<TContext> : DbContext where TContext : DbContext
    //{
     

    //}
}