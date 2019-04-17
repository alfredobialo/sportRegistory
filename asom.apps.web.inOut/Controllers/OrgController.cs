using System;
using System.Web.Mvc;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using asom.apps.web.inOut.Models.Settings;
using itrex.businessObjects.model.core.LicenseApi;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Controllers
{
    public class OrgController : SecuredAppController
    {
        // GET: Orh
        protected ActionResult GetCompanyInfo()
        {
            //Thread.Sleep(4000);
            CompanyInfoModel info  = OrganizationInfo.Get();
            var res = new
            {
                success = true,
                data = info,
                message = "Company Info loaded"
            };

            return Content(JsonConvert.SerializeObject(res,MyConfig.DefaultJsonSettings));
        }
        [HttpPost]
        protected ActionResult EditCompany(string companyInfo)
        {
          
            if (string.IsNullOrEmpty(companyInfo))
            {
                return FailedAction("Could not validate input");
            }

            CompanyInfoModel org = JsonConvert.DeserializeObject<CompanyInfoModel>(companyInfo,MyConfig.DefaultJsonSettings);
            if (org != null)
            {
                OrganizationInfo res = (OrganizationInfo) org;
                res.SaveRecord();
                org = res;
                return SuccessAction("Company Profile Saved",org);

            }
            
          return FailedAction("Could Update company record");
           

        }

        protected ActionResult GetSettings()
        {
            SettingModel setting = OrganizationInfo.GetSettings();
            var data = new
            {
                data  = setting,
                success = true,         
            };
            return Content(JsonConvert.SerializeObject(data, MyConfig.DefaultJsonSettings));
        }
        protected ActionResult GetInvoiceTemplate()
        {
            var crud = InvoiceTemplate.GetInvoiceTemplates();
            return CrudOperaResult(crud);
        }
        protected ActionResult SaveViewMode(byte mode)
        {
            bool success = false;

//            if (User.Identity.IsAuthenticated)
//            {
                 var main = OrganizationInfo.GetSettings();
                if (main != null)
                {
                    main.ViewMode = mode;
                    success  = main.Save();
                     var data = new
                    {
                        success = success, 
                        message = success ? "Viem mode saved" :"Oops ! Could not completed operation"       
                    };
                    return Content(JsonConvert.SerializeObject(data, MyConfig.DefaultJsonSettings));
                }
//            }
           
            return FailedAction("Could Not save your preference. Please try and login again");
           
        }

        protected ActionResult GetAllBusinessChannels()
        {
            if (User.Identity.IsAuthenticated)
            {
                return CrudOperaResult(BusinessChannelModel.GetChannels());
            }
            return AuthenticationRequiredAction;
        }
        protected ActionResult GetUploadedAppLicense()
        {
            /*This will open the installed license if found for validation*/
            ServerResponseModel  res =  new ServerResponseModel(); 
//            if (User.Identity.IsAuthenticated)
//            {
                try
                {
                    res = AppInfo.Get.GetUploadedAppLicense();

                }
                catch (Exception err)
                {
                    res.Message = err.Message;
                    res.ServerException = err;
                }
                return CrudOperaResult(res);
//            }
           
        }
        protected ActionResult GetUploadedLicenseExtender()
        {
            /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                res = AppInfo.Get.GetUploadedExtender();

            }
            catch (Exception err)
            {
                res.Message = err.Message;
                res.ServerException = err;
            }
            return CrudOperaResult(res);
            //            }

        }
        protected ActionResult ExtendAppLicense()
        {
            /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                res = AppInfo.Get.ExtendAppLicense();
                // Still in progress
            }
            catch (Exception err)
            {
                res.Message = err.Message;
                res.ServerException = err;
            }
            return CrudOperaResult(res);
       

        }
        protected ActionResult GetAppLicense()
        {
            /*This will open the installed license if found for validation*/
            ServerResponseModel  res =  new ServerResponseModel(); 
//            if (User.Identity.IsAuthenticated)
//            {
                try
                {
                    res = AppInfo.Get.GetAppLicense();

                }
                catch (Exception err)
                {
                    res.Message = err.Message;
                    res.ServerException = err;
                }
                return CrudOperaResult(res);
//            }
           
        }
   
        protected ActionResult SaveSettings(string settings)  // 300
        {
            // TODO : Check User Permission Here
            if (!User.Identity.IsAuthenticated)
            {
                return this.AuthenticationRequiredAction;
            }
            // Deserialize the theme
            if (string.IsNullOrEmpty(settings))
            {
                return FailedAction("Required data not supplied!");
            }
            try
            {
                SettingModel obj = JsonConvert.DeserializeObject<SettingModel>(settings, MyConfig.DefaultJsonSettings);
                ServerResponseModel res = SettingModel.SaveSettings(obj);
                return CrudOperaResult(res);
            }
            catch (Exception err)
            {
                FailedAction("Internal Server Error!  : " +err.Message);
            }
            return FailedAction("Server Failure!");

        }
        protected ActionResult ActivateAppLicense()
        {
            /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
//            if (User.Identity.IsAuthenticated)
//            {
                try
                {
                    string serverPath = Server.MapPath(AppInfo.Get.LICENSE_FILE_PATH);
                    // Open the license
                    AsomAppLicenseGenetrator.OnLicenseActivated += (o, args) =>
                    {
                        res.Message = args.Message;
                    };
                    AsomAppLicense lic = AsomAppLicenseGenetrator.ActivateLicense(serverPath);
                    
                    res.Success = true;
                    //res.Message = lic.AppDefinition.AppName + ", License TO : " + lic.AppDefinition.LicenseToCompanyName;
                    res.Data = lic;
                //  Log user out for update to take effect
//                    IdentitySession.Clear();
//                    Session.Clear();
//                    FormsAuthentication.SignOut();
            }
                catch (Exception err)
                {
                    res.Message = err.Message;
                    res.ServerException = err;
                }
                return CrudOperaResult(res);
//            }
          
        }

        // Define Application license specific URL
       



         const int URL_COMPANY_INFO = 1;
         const int URL_COMPANY_SETTINGS = 2;
         const int URL_COMPANY_EDIT = 3;
            const int URL_SAVE_SETTINGS = 30;
         const int URL_VIEW_MODE_SETTING = 4;
         const int GET_INVOICE_SETTINGS = 40;
            
         const int URL_ALL_BUSINESS_CHANNEL = 5;
         const int URL_LICENSE_INFO = 100;
         const int URL_LICENSE_ACTIVATION = 101;
         const int URL_UPLOAD_LICENSE_INFO = 102;
        const int URL_EXTENDE_LICENSE = 103;
         const int URL_READ_UPLOADED_LICENSE_EXTENDER = 104;
        public override ActionResult GetUrl(int? key, string data, string criteria, string extradata = null, bool trueFalse = false)
        {
            switch (key)
            {
                case URL_COMPANY_INFO:
                    return GetCompanyInfo();
                   
                case URL_COMPANY_SETTINGS:
                    return GetSettings();
                   
                case URL_COMPANY_EDIT:
                    return EditCompany(data);
                case URL_SAVE_SETTINGS:
                    return SaveSettings(data);

                case URL_VIEW_MODE_SETTING:

                    return SaveViewMode(Convert.ToByte(data));

                case GET_INVOICE_SETTINGS:
                    return GetInvoiceTemplate();
                case URL_ALL_BUSINESS_CHANNEL:

                    return GetAllBusinessChannels();
                case URL_LICENSE_INFO:

                    return GetAppLicense();
                case URL_LICENSE_ACTIVATION:

                    return ActivateAppLicense();
                case URL_UPLOAD_LICENSE_INFO:

                    return GetUploadedAppLicense();
                case URL_EXTENDE_LICENSE:

                    return ExtendAppLicense();
                case URL_READ_UPLOADED_LICENSE_EXTENDER:

                    return GetUploadedLicenseExtender();
                default:
                    return GetCompanyInfo();
            }
            return base.GetUrl(key, data, criteria, extradata, trueFalse);
        }

//        public ActionResult GetUrl(int? key, string data=null, string criteria=null)
//        {
//            
//        }
    }




}