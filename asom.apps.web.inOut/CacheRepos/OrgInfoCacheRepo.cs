using System;
using System.Web;
using System.Web.Caching;
using asom.apps.inOut.core.dal.sqlserver.model;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Models;
using itrex.businessObjects.model.core;

namespace asom.apps.web.inOut.CacheRepos
{
    public class OrgInfoCacheRepo   : OrgRepo
    {

        // Implement Cache Pattern here
        private HttpContext context = HttpContext.Current;
        private static Cache cache;
        public const int SINGLE_CACHE_DURATION = 60 * 60 * 3; // 3 hours
        public const int MULTIPLE_CACHE_DURATION = 60 * 60 * 24 * 30; // 30 days
        private static string CACHE_KEY = "ORG_INFO_CACHE_KEY";
        private static OrganizationInfo cacheDb = null;//OrganizationInfo.Get();
        void createCache()
        {
            if (cache != null)
            {
                if (cache[CACHE_KEY] == null)
                    cache.Add(CACHE_KEY, cacheDb, null, DateTime.UtcNow.AddSeconds(MULTIPLE_CACHE_DURATION), Cache.NoSlidingExpiration, CacheItemPriority.Default,
                    null);
            }
        }


        public OrgInfoCacheRepo()
        {
            cache = context.Cache;
            if (context.User != null)
            {
                 var app = AppConfig.GetInstance();
                app.SetCurrentUserFromThread(context.User);
                app.CurrentUser = IdentitySession.GetOrCreate();
                CurrentUserContext = app.CurrentUser;
            }
           
//            createCache();
        }
        public override void Save(OrganizationInfo obj)
        {
            base.Save(obj);
            // add to cache if no Error
            cache[CACHE_KEY] = obj;
        }

        public override OrganizationInfo Get(object id)
        {
            if (cache[CACHE_KEY] == null)
            {
                var res = base.Get(id);
                cacheDb = res;
                createCache();
                return res;
            }
            else
            {
                return cache[CACHE_KEY] as OrganizationInfo; ;
            }


        }

        public override void Update(OrganizationInfo obj)
        {
            base.Update(obj);
            cache[CACHE_KEY] = obj;
        }
    }
}