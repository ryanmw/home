using System.Web.Mvc;
using RMW.Repository;
using RMW.Web.Operational;
using System;

namespace RMW.Web.Controllers
{
    public class SiteMapController : Controller
    {
        [Route("/sitemap.xml")]
        public ActionResult SiteMap()
        {
            var domainRoot = string.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Host);

            var siteMapHelper = new SiteMapHelper();

            var articles = new ArticleRepository();

            foreach (var article in articles.All)
            {
                var url = new Uri(article.URLTo);

                siteMapHelper.AddUrl(url.ToString(), DateTime.UtcNow.AddDays(-1), ChangeFrequency.weekly, .5);
            }

            siteMapHelper.AddUrl(domainRoot + "/home/about", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/home/resume", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/home/contact", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/articles", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/home/about", DateTime.UtcNow, ChangeFrequency.monthly, .7);

            var xml = siteMapHelper.GenerateXml();

            return this.Content(xml, "text/xml");
        }

 
    }
}