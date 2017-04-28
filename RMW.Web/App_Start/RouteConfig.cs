using System.Web.Mvc;
using System.Web.Routing;

namespace RMW
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                 "ArticleItem",
                 "articles/{yyyy}/{mm}/{dd}/{key}"  ,
                new { controller = "Articles", action = "Display" }
            );

            routes.MapRoute(
                 "ArticlePage",
                 "articles/page/{pageNumber}",
                new { controller = "Articles", action = "Page" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
        }
    }
}