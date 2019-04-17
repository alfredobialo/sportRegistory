using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using asom.apps.web.inOut.CacheRepos;
using asom.apps.web.inOut.Properties;

namespace asom.apps.web.inOut
{
    public class Global : HttpApplication
    {
        private void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
//            AppConfig.ConnectionString =
//                System.Web.Configuration.WebConfigurationManager.AppSettings["connStringName"].ToString();

            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            if (Settings.Default.useHttps == true)
            {
                // Use Https
                GlobalFilters.Filters.Add(new RequireHttpsAttribute());
            }
            // check if the app has been installed
            var sect = WebConfigurationManager.AppSettings["setupInit"];
            if (sect != null)
            {
                if (sect.ToLower() == "true")
                {
                    
                }
               
            }
        InitCacheDataSource.InitDatabaseConnectionString();

//            InitCacheDataSource.Init();

        }

        

        private void Session_Start(object sender, EventArgs e)
        {
//            InitCacheDataSource.Init();
        }

//        public void AuthorizeRequest(object sender, EventArgs e)
//        {
//            
//        }

    }
}