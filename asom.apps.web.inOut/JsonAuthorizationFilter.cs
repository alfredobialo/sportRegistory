using System.Web.Mvc;

namespace asom.apps.web.inOut
{
    public class JsonAuthorizationFilter  : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            
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