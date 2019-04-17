using System.Web.Mvc;
using asom.apps.web.inOut.Models;
using itrex.businessObjects.model.core;

namespace asom.apps.web.inOut
{
    public class IdentityStoreAuthorizationFilter  : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.RequestContext.HttpContext.User != null && filterContext.HttpContext.User.Identity.IsAuthenticated)
            {
                var app= AppConfig.GetInstance();
                app.SetCurrentUserFromThread(filterContext.HttpContext.User);
                app.CurrentUser = IdentitySession.GetOrCreate();
            }
            base.OnActionExecuting(filterContext);
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {

            if (!filterContext.HttpContext.User.Identity.IsAuthenticated)
            {
//                filterContext.Result = BaseController.FailedAction("Please Login To Continue", new List<ValidationLog>());
                return;
            }
            
            base.OnResultExecuted(filterContext);
        }
    }
}