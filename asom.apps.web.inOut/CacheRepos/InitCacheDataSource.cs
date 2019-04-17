using System;
using System.Web.Configuration;
using asom.apps.inOut.core.config;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.web.inOut.CacheRepos
{
    public class InitCacheDataSource
    {
        internal static void SetDatabaseConnectionString(string conStr)
        {
            // set up database connection string
           
            if (!string.IsNullOrEmpty(conStr))
            {
              AppConfig.ConnectionString = conStr;
            }
        }
        internal static void InitDatabaseConnectionString(string constring)
        {
            // set up database connection string
            string appConnectionString = constring;
                
//            if (!string.IsNullOrEmpty(appConnectionString))
//            {
                //                ServerConnection servConnection  =  new ServerConnection(new SqlConnectionInfo());
                try
                {
                  

                    // Try and open the given connection (PING)
//                    bool success  = AppInstallation.PingDbServer(appConnectionString);
//                    if (success)
//                    {
                         
                         AppConfig.ConnectionString = constring;
                        AppConfig.GetInstance().DbConnectionString = appConnectionString;
                         Init();
//                    }
                   
                }
                catch (Exception err)
                {
                    // Connecting to server
                }
               

//            }
        }
        internal static void InitDatabaseConnectionString()
        {
            // set up database connection string
            string appConnectionString =
                WebConfigurationManager.ConnectionStrings["sports_db"].ConnectionString;
            if (!string.IsNullOrEmpty(appConnectionString))
            {
                //                ServerConnection servConnection  =  new ServerConnection(new SqlConnectionInfo());
                try
                {
                    // Try and open the given connection (PING)
                    bool success = true; // AppInstallation.PingDbServer(appConnectionString);
                    if (success)
                    {
                         
                        AppConfig.ConnectionString = appConnectionString;
                        AppConfig.GetInstance().DbConnectionString = appConnectionString;
                        Init();
                    }
                   
                }
                catch (Exception err)
                {
                    // Connecting to server
                }
               

            }
        }
        public static void Init()
        {
            // Ensure The Database Server  is Running
            try
            {
                // Clear all Caches
//                var cache = HttpContext.Current.Cache;
                
//                ObjDataSourceFactory<OrgAppSetting>.DataSource = new OrgSettingsCacheRepo();
//                ObjDataSourceFactory<OrganizationInfo>.DataSource  =  new OrgInfoCacheRepo();
//                ObjDataSourceFactory<IdentityStore>.DataSource  =  new IdentityStoreCacheRepo();
//                ObjDataSourceFactory<ItemCategory>.DataSource  =  new CategoryCacheRepo();
            }
            catch (Exception err)
            {
                throw new Exception(err.Message);
            }
           
//            
        }
    }
   

}