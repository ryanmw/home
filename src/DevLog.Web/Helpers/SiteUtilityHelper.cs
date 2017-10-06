using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Specialized;
using System.Globalization;
using System.Text.RegularExpressions;

namespace DevLog.Web.Helpers
{
    public static class SiteUtilityHelper
    {
        /// <summary>
        /// Gets a URL accessible dash spaced string 
        /// </summary>
        /// <param name="p"></param>
        /// <returns></returns>
        public static string WebSafeMaker(string p)
        {
            var pname = Regex.Replace(p, @"[\W_-[#]]+", " ");
            return pname.Trim().Replace("  ", " ").Replace(" ", "-").Replace("%", string.Empty).ToLowerInvariant();
        }


        private static readonly Random Rand = new Random();

        public static int RandomNumber(int min, int max)
        {
            var t = Rand.Next(min, max);
            return t;
        }


        public static string ArticleUrl(DateTime publishDate, string key)
        {
            return string.Format(
                    CultureInfo.InvariantCulture,
                    "/articles/{0}/{1}/{2}/{3}",
                    publishDate.Year.ToString("0000", CultureInfo.InvariantCulture),
                    publishDate.Month.ToString("00", CultureInfo.InvariantCulture),
                    publishDate.Day.ToString("00", CultureInfo.InvariantCulture),
                    key);
        }

        /// <summary>
        /// A simple bot prevention technique
        /// </summary>
        /// <param name="formCollection"></param>
        /// <returns></returns>
        public static bool IsCaptchaValid(IFormCollection formCollection)
        {
            if (!string.IsNullOrWhiteSpace(formCollection["num1"]) &&
              !string.IsNullOrWhiteSpace(formCollection["num2"]) &&
              !string.IsNullOrWhiteSpace(formCollection["userans"])
              )
            {
                int num1;
                if (int.TryParse(formCollection["num1"], out num1))
                {
                    int num2;
                    if (int.TryParse(formCollection["num2"], out num2))
                    {
                        int userans;
                        if (int.TryParse(formCollection["userans"], out userans))
                        {
                            if (num1 + num2 == userans)
                            {
                                return true;
                            }

                        }
                    }
                }
            }
            return false;
        }



        public static string GetIpAddress(IHttpContextAccessor contextAccessor)
        {
            var ip = contextAccessor.HttpContext.Connection.RemoteIpAddress.MapToIPv4().ToString();

            return ip;
        }
    }
}
