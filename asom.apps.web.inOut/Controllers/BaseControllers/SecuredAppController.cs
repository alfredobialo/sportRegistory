using System.Threading.Tasks;
using System.Web.Mvc;

namespace asom.apps.web.inOut.Controllers.BaseControllers
{
//    [JsonAuthorizationFilter]
    public class SecuredAppController : BaseController
    {
        protected ActionResult CheckIfUserIsAuthencated()
        {
            if (!User.Identity.IsAuthenticated)
            {
                return FailedAction("Authentication Required");
            }
            else
            {
                return SuccessAction("Authenticated" , true);
            }
        }

        public SecuredAppController()
        {
//            AppConfig.GetInstance().SetCurrentUserFromThread(User);

        }
        public virtual Task<ActionResult> GetUrlAsync(int? key, /*string module,*/ string data, string criteria, string extradata = null, bool trueFalse = false)
        {
            var task = Task.Factory.StartNew(() =>
            {
                return GetUrl(key, data, criteria, extradata, trueFalse);
            });
            return task;
        }
        public virtual ActionResult GetUrl(int? key, /*string module,*/ string data, string criteria, string extradata = null, bool trueFalse = false)
        {

            return FailedAction("Required URL parameters not supplied, Please override this action!");
        }
    }
}