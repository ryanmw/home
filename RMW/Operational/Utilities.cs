using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

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
            string pname = Regex.Replace(p, @"[\W_-[#]]+", " ");
            return pname.Trim().Replace("  ", " ").Replace(" ", "-").Replace("%", string.Empty).ToLowerInvariant(); // TODO: FULL REGEX
        }


        private static Random rand = new Random();

        public static int RandomNumber(int min, int max)
        {
            int t = rand.Next(min, max);
            return t;
        }

        public static bool IsCaptchaValid(NameValueCollection nvc)
        {
            if (!string.IsNullOrWhiteSpace(nvc["num1"]) &&
              !string.IsNullOrWhiteSpace(nvc["num2"]) &&
              !string.IsNullOrWhiteSpace(nvc["userans"])
              )
            {
                int num1 = 0;
                int num2 = 0;
                int userans = 0;

                if (int.TryParse(nvc["num1"], out num1))
                {
                    if (int.TryParse(nvc["num2"], out num2))
                    {
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