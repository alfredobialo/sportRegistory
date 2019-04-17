using System.Web.Mvc;

namespace asom.apps.web.inOut
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new IdentityStoreAuthorizationFilter());
        }
    }
}
