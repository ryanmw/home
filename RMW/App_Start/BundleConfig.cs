using System.Web.Optimization;

namespace RMW
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/Content/css/css_head1").Include(
                      "~/content/css/normalize.css",
                      "~/content/css/main.css"
              ));



            bundles.Add(new ScriptBundle("~/bundles/js_head1").Include(
              "~/scripts/vendor/modernizr-2.6.1-respond-1.1.0.js" ));
        }
    }
}