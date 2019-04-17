using System;
using System.Web;
using System.Web.Caching;
using asom.apps.inOut.core.dal.sqlserver.model;
using asom.apps.inOut.core.model.org;

namespace asom.apps.web.inOut.CacheRepos
{
    public class OrgSettingsCacheRepo  : OrgSettingRepo
    {
       // TODO : Ensure that Permissions are validated on Cached Repos

            // Implement Cache Pattern here
            private HttpContext context = HttpContext.Current;
            private static Cache cache;
            public const int SINGLE_CACHE_DURATION = 60 * 60 * 3; // 3 hours
            public const int MULTIPLE_CACHE_DURATION = 60 * 60 * 24 * 10; // 10 hours
            private static string CACHE_KEY = "ORG_SETTINGS_CACHE_KEY";
            private static OrgAppSetting cacheDb = null;//OrganizationInfo.GetSettings();
            void createCache()
            {
                if (cache != null)
                {
                    if (cache[CACHE_KEY] == null)
                        cache.Add(CACHE_KEY, cacheDb, null, DateTime.UtcNow.AddSeconds(MULTIPLE_CACHE_DURATION), Cache.NoSlidingExpiration, CacheItemPriority.Default,
                        null);
                }
            }

         
            public OrgSettingsCacheRepo()
            {
                cache = context.Cache;
//                createCache();
            }
            public override void Save(OrgAppSetting obj)
            {
                base.Save(obj);
                // add to cache if no Error
                //cacheDb = obj;
                cache[CACHE_KEY] = obj;
        }

        public override OrgAppSetting Get(object id)
        {
            if (cache[CACHE_KEY]  == null || cacheDb == null)
            {
               var res =  base.Get(id);
                if (res == null)
                {
                     OrgAppSetting.Instance().SaveSettings();
                    res = base.Get(OrganizationInfo.ORG_SETTING_CODE);
                }
                cacheDb = res;
                createCache();
                return res;
            }
            else
            {
                // return  settings stored in cache

                return cache[CACHE_KEY] as OrgAppSetting;
            }

            
        }

        public override void Update(OrgAppSetting obj)
        {
            base.Update(obj);
            cache[CACHE_KEY]= obj;
        }
    }
}