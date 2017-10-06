using DevLog.Data.Models;
using DevLog.Web.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;


namespace DevLog.Web.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public AccountController(
          UserManager<ApplicationUser> userManager,
          SignInManager<ApplicationUser> signInManager,
          RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult Login()
        {
            return View();
        }


        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public IActionResult Login(LoginViewModel model, string returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;

            if (ModelState.IsValid)
            {
                if (!IsValidPassword(model))
                {
                    ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                    return View(model);
                }
                
                if (!EmailIsConfirmed(model.Email, out ApplicationUser user))
                {
                    ModelState.AddModelError(string.Empty, "You must have a confirmed email to log in.");
                    return View(model);
                }

                return RedirectToAction("Index", "Admin");
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> LogOff()
        {
            await _signInManager.SignOutAsync();

            return RedirectToAction(nameof(HomeController.Index), "Home");
        }
 
        public async Task AddUserToRole(ApplicationUser user, string role)
        {
            var admin = await _roleManager.FindByNameAsync(role);

            if (admin == null)
            {
                admin = new IdentityRole(role.ToString());
                await _roleManager.CreateAsync(admin);
            }

            if (!await _userManager.IsInRoleAsync(user, admin.Name))
            {
                await _userManager.AddToRoleAsync(user, admin.Name);
            }
        }

        private bool EmailIsConfirmed(string email, out ApplicationUser applicationUser)
        {
            var user = Task.Run(() => _userManager.FindByNameAsync(email)).Result;

            applicationUser = user;

            applicationUser.EmailConfirmed = true;
            _userManager.UpdateAsync(applicationUser);

            if (user == null)
                return false;

            if (Task.Run(() => _userManager.IsEmailConfirmedAsync(user)).Result)
                return true;

            return false;
        }

        private bool IsValidPassword(LoginViewModel model)
        {
            var result = Task.Run(() => _signInManager.PasswordSignInAsync(
                    model.Email,
                    model.Password,
                    model.RememberMe,
                    lockoutOnFailure: false)).Result;

            return result.Succeeded && !result.IsLockedOut;

        }

    }
}
