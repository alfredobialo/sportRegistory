using System.Web.Mvc;
using asom.apps.web.inOut.Controllers.BaseControllers;

namespace asom.apps.web.inOut.Controllers
{
    public class XhrUrlMapperController : BaseController
    {
        // GET: XhrUrlMapper
        private const string MODULE_COMPANY_PROFILE = "org-info";
        private const string MODULE_PARTIAL = "partials";
        private const string MODULE_UTIL = "util";
        private const string MODULE_menu = "menu";
        private const string MODULE_Hr = "hr";
        private const string MODULE_Inventory = "inv";
        private const string MODULE_Crm = "crm";
        private const string MODULE_Sales = "sales";
        private const string MODULE_Identity = "identity";
        private const string MODULE_Themes = "themes";
        const  string MODULE_Identity_login  = "login";
        public XhrUrlMapperController()
        {
            
        }
        public virtual ActionResult GetUrl(int? key, string module, string data, string criteria, string extradata = null,
            bool trueFalse = false)
        {
            module = module.ToLower();
            
            switch (module)
            {
                case MODULE_COMPANY_PROFILE:
                    return RedirectToAction("GetUrl", "Org", new { key=key,data=data, criteria=criteria});
                case MODULE_PARTIAL:
                    return RedirectToAction("FindPartial", "AppPartialViewBase", new { id=data});
                case MODULE_UTIL:
                    return  new UtilController().GetUrl(key,data,criteria);
                    //return RedirectToAction("GetUrl", "Util", new { key=key,data=data, criteria=criteria});
                case MODULE_menu:
                    return RedirectToAction("find-submenu", "Menu", new { id=data});
               
                

                //                case MODULE_Crm:
                //                    return new CrmController().GetUrl(key,data,criteria);
                // case MODULE_Sales:
                //                    return new CrmController().GetUrl(key,data,criteria);
                case MODULE_Identity:
                    return RedirectToAction("GetUrl", "Identity", new { key=key,data=data, criteria=criteria, trueFalse = trueFalse});
                case MODULE_Identity_login:
                    return RedirectToAction("Login", "Home", new { data = data});

                case MODULE_Themes:
                    return RedirectToAction("themesUrl", "Home", new { key=key,data=data});
                 
            }
            return FailedAction("failed");
        }
    }
}