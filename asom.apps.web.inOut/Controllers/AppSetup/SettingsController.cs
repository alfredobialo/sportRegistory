using System.Web.Mvc;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using asom.apps.web.inOut.Models.Settings;

namespace asom.apps.web.inOut.Controllers.AppSetup
{
    public class SettingsController : SecuredAppController
    {

       const int GET_SETTINGS = 100;

        protected ActionResult GetAppSettings()
        {
            ServerResponseModel crud  =  new ServerResponseModel();
            crud.Success = false;
            crud.Message = "Settings Not Found";
            crud.IsAuthorize = false;

            if (User.Identity.IsAuthenticated)
            {
                var settingObject = OrganizationInfo.GetSettings();
                // serialize
                if (settingObject != null)
                {
                    crud.Message = "Settings Loaded";
                    crud.IsAuthorize = true;
                    crud.Success = true;
                    crud.Data = (SettingModel) settingObject;

                }
            }
            else
            {
                crud.Message = "Please Login First";
            }
            // Just Get The current Application Settings
            return CrudOperaResult(crud);
        }

        // GET: Settings
        public override ActionResult GetUrl(int? key, string data, string criteria, string extradata = null, bool trueFalse = false)
        {
            switch (key)
            {
                case GET_SETTINGS:
                    return GetAppSettings();
            }
            return base.GetUrl(key, data, criteria, extradata, trueFalse);
        }
    }
}