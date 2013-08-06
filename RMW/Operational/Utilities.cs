using System;
using System.Collections.Specialized;
using System.Text.RegularExpressions;

namespace RMW.Operational
{
    public static class Utilities
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

        /// <summary>
        /// A simple bot prevention technique
        /// </summary>
        /// <param name="nvc"></param>
        /// <returns></returns>
        public static bool IsCaptchaValid(NameValueCollection nvc)
        {
            if (!string.IsNullOrWhiteSpace(nvc["num1"]) &&
              !string.IsNullOrWhiteSpace(nvc["num2"]) &&
              !string.IsNullOrWhiteSpace(nvc["userans"])
              )
            {
                int num1;
                if (int.TryParse(nvc["num1"], out num1))
                {
                    int num2;
                    if (int.TryParse(nvc["num2"], out num2))
                    {
                        int userans;
                        if (int.TryParse(nvc["userans"], out userans))
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

    }
}