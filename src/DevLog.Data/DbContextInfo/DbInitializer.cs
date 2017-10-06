using DevLog.Data.Models;
using Microsoft.AspNetCore.Identity;
using System.Linq;
using System.Threading.Tasks;

namespace DevLog.Data.DbContextInfo
{
    public class DbInitializer : IDbInitializer
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public DbInitializer(
            ApplicationDbContext context,
            UserManager<ApplicationUser> userManager,
            RoleManager<IdentityRole> roleManager)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public void Initialize()
        {
            _context.Database.EnsureCreated();

            var roleName = "Administrator";
            if (!_context.Roles.Any(r => r.Name == roleName))  
            {
                Task.Run ( () =>_roleManager.CreateAsync(new IdentityRole(roleName)));
            }

            string user = "YOUREMAIL@EMAIL.COM";
            string password = "YOURPASSWORD";

            if (!_context.Users.Any(r => r.UserName == user))
            {
                var userResult = Task.Run(() => _userManager.CreateAsync(new ApplicationUser { UserName = user, Email = user, EmailConfirmed = true }, password)).Result;
                var addUserResult = Task.Run(() => _userManager.AddToRoleAsync(Task.Run(() => _userManager.FindByNameAsync(user)).Result, roleName)).Result;
            }
        }
    }
}
