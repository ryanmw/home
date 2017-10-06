using System;
using Microsoft.AspNetCore.Mvc;
using DevLog.Data.Enums;
using DevLog.Data.Repositories.Interfaces;
using DevLog.Web.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;

namespace DevLog.Web.Controllers
{
    public class SiteMapController : Controller
    {
        private readonly IArticleRepository _articleRepository;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public SiteMapController(
            IArticleRepository articleRepository,
            IHttpContextAccessor httpContextAccessor)
        {
            _articleRepository = articleRepository;
            _httpContextAccessor = httpContextAccessor;
        }

        [Route("/sitemap.xml")]
        public ActionResult Index()
        {
            var displayUrl = new Uri(UriHelper.GetDisplayUrl(_httpContextAccessor.HttpContext.Request));
            var domainRoot = string.Format("{0}://{1}", displayUrl.Scheme, displayUrl.Host);
            var siteMapHelper = new SiteMapHelper();

            foreach (var article in _articleRepository.All)
            {
                var url = new Uri(domainRoot + SiteUtilityHelper.ArticleUrl(article.PublishedOn, article.Key));

                siteMapHelper.AddUrl(url.ToString(), DateTime.UtcNow.AddDays(-1), ChangeFrequency.weekly, .5);
            }

            siteMapHelper.AddUrl(domainRoot + "/resume", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/contact", DateTime.UtcNow, ChangeFrequency.monthly, .7);
            siteMapHelper.AddUrl(domainRoot + "/articles", DateTime.UtcNow, ChangeFrequency.monthly, .7);

            var xml = siteMapHelper.GenerateXml();

            return this.Content(xml, "text/xml");
        }
    }
}