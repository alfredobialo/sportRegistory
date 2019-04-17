using System.Threading;
using System.Web;
using System.Web.Caching;
using asom.apps.inOut.core.model.authentication;
using asom.apps.web.inOut.Models;
using itrex.businessObjects.model.core;

namespace asom.apps.web.inOut.CacheRepos
{
    public class IdentityStoreCacheRepo  : IdentityStoreRepo
    {
        private HttpContext context = HttpContext.Current;
        private static Cache cache;
        public const int SINGLE_CACHE_DURATION = 60 * 60 * 3; // 3 hours
        public const int MULTIPLE_CACHE_DURATION = 60 * 60 * 24 * 10; // 10 hours
        private static string CACHE_KEY = "ORG_USERS_CACHE_KEY";
        public IdentityStoreCacheRepo()
        {
            var principle = Thread.CurrentPrincipal;
            if (principle != null)
            {
                var app = AppConfig.GetInstance();
                app.SetCurrentUserFromThread(principle);
//                app.CurrentUser = IdentitySession.GetOrCreate();
                CurrentUserContext = app.CurrentUser;
            }
        }

       

        public override CrudOperationResult<IdentityStore> UpdateObject(IdentityStore obj, Criteria criteria)
        {
            UserIdentityModel res = obj;
           
            IdentitySession.UpdateUser(res);
            return base.UpdateObject(obj, criteria);
        }
    }
}