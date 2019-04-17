using System.Web.Optimization;

namespace asom.apps.web.inOut
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {

            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-1.10.2.min.js",
                        "~/Scripts/jquery.countdown.min.js",
                        "~/Scripts/jquery.signalR-2.1.2.min.js"
                        ));
            
            bundles.Add(new ScriptBundle("~/inOut/lib").Include(
                        "~/Scripts/inOutapi/inOut.js",
                        "~/Scripts/inOutapi/modules/*.js"
//                        "~/Scripts/inOutapi/controllers/*.js",
//                        "~/Scripts/inOutapi/models/*.js"
                        ));
            bundles.Add(new ScriptBundle("~/inOut/Init").Include(
                       "~/Scripts/inOutapi/modules/appStartModule.js",
                        "~/Scripts/inOutapi/modules/toastmodule.js",
                       "~/Scripts/inOutapi/modules/userIdentityModule.js",
                       "~/Scripts/inOutapi/modules/fileUploadModule.js",
                       "~/Scripts/inOutapi/modules/setupModule.js",
                       "~/Scripts/inOutapi/modules/settingsModule.js",
//                       "~/Scripts/inOutapi/modules/licenseModule.js",
                       "~/Scripts/inOutapi/modules/directivesModule.js"
                        ));
            bundles.Add(new ScriptBundle("~/required/libs").Include(
                        "~/Scripts/asom_utils.js",
                        "~/Scripts/moment/moment.min.js",
                        "~/Scripts/ng/angular.min.js",
                        "~/Scripts/ng/angular-messages.min.js",
                        "~/Scripts/ng/angular-sanitize.min.js",
                        "~/Scripts/ng/angular-animate.min.js",
                        "~/Scripts/ng/angular-aria.min.js",
                        "~/Scripts/ng/angular-ui-router.min.js",
                        "~/Scripts/ng/angular-material.min.js",
//                        "~/Scripts/ng/core.min.js", "~/Scripts/ng/progresslinear.min.js",
                      "~/Scripts/ng/ui-bootstrap-tpls-1.3.2.min.js",
                      "~/Scripts/ng/select.min.js",
//                      "~/Scripts/ng/select2.min.js",
//                      "~/Scripts/ng/selectize.min.js",
//                        "~/Scripts/ng/ui-bootstrap-tpls-1.1.0.min.js",

                        "~/Scripts/lodash/lodash.min.js"

                        ));

            bundles.Add(new ScriptBundle("~/required/components").Include(
//                          "~/Scripts/greensock-js/minified/TweenMax.min.js",
//                        "~/Scripts/greensock-js/minified/jquery.gsap.min.js",
                        "~/Scripts/highchart4/highcharts.js",
                        "~/Scripts/highchart4/highcharts-3d.js"
                        ));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
//                      "~/Scripts/bootstrap.min.js",
                      "~/Scripts/respond.js"));
//            bundles.Add(new StyleBundle("~/base/ionic/css")
//                .Include("~/styles/ionic/css/ionicons.min.css"));

            bundles.Add(new StyleBundle("~/base/css").Include(
//                      "~/styles/btrap/bootstrap.min.css",
                      "~/styles/angular-material.min.css",
                      "~/styles/base/select.min.css",
                      "~/styles/base/select2.min.css",
                      /*"~/styles/base/selectize.css",
                      "~/styles/base/selectize.bootstrap3.css",*/
                      "~/styles/base/theme-base.css"));

          bundles.Add(new StyleBundle("~/btc/css/font").Include(
            "~/btcTemplate/css/font-awesome.min.css",
           
            "~/btcTemplate/css/simple-line-icons.css"
           
         ));
      bundles.Add(new StyleBundle("~/btc/css").Include(
           
            "~/btcTemplate/css/jquery.lightbox.min.css",
            
            "~/btcTemplate/css/style.css"
         ));
//           BundleTable.EnableOptimizations = true;

        }
    }
}
