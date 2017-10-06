using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using DevLog.Data.DbContextInfo;
using DevLog.Data.Repositories.Interfaces;
using DevLog.Data.Repositories.Implementations;
using Microsoft.AspNetCore.Rewrite;
using DevLog.Web.AppRules;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using DevLog.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace DevLog.Web
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("SqlServerConnection")));

            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();


            // db repos
            services.AddTransient<IArticleRepository, ArticleRepository>();
            services.AddTransient<ICommentRepository, CommentRepository>();
            services.AddTransient<ILog4NetRepository, Log4NetRepository>();
         
            // db context
            services.AddTransient<IApplicationDbContext, ApplicationDbContext>();

            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

            services.AddScoped<IDbInitializer, DbInitializer>();


            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IDbInitializer dbInitializer)
        {
            var options = new RewriteOptions();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseBrowserLink();
            }
            else
            {
                options.AddRedirectToHttps(301);

                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();
            app.UseAuthentication();

            options.Rules.Add(new NonWwwRule());

            app.UseRewriter(options);

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
