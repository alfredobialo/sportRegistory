using System;
using System.Configuration;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using asom.apps.inOut.core.config;
using asom.apps.web.inOut.CacheRepos;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Controllers.AppSetup
{
    public class SetupController : SecuredAppController
    {
       
        // GET: Setup
        public ActionResult Index()
        {
            var setup = WebConfigurationManager.AppSettings["setupInit"];
            if (!string.IsNullOrEmpty(setup))
            {
                if (setup.ToLower() == "true")
                {
                    return RedirectToAction("Index", "FrontEnd");
                }
            }
            FormsAuthentication.SignOut();
            IdentitySession.Clear();
            return View();
        }

        public ActionResult PatchDatabase()
        {
            /*
             * Only run this code if the Setup process has completed
             * if we setup is complete, disable this function because we don't need it after a fresh installation
             * 
             */
             var setup = WebConfigurationManager.AppSettings["setupInit"];
            if (!string.IsNullOrEmpty(setup))
            {
                if (setup.ToLower() != "true")
                {
                    return RedirectToAction("Sys", "Home");
                }
            }
            var dbSet = WebConfigurationManager.AppSettings["patchDb"];
            if (!string.IsNullOrEmpty(dbSet))
            {
                if (dbSet.ToLower() != "true")
                {
                    return RedirectToAction("Sys", "Home");
                }
            }
            // Patch the Database

            return View("PatchDb");
        }


        [HttpPost][AllowAnonymous]
        public ActionResult DbPatch()
        {
            var dbSet = WebConfigurationManager.AppSettings["patchDb"];
            if (!string.IsNullOrEmpty(dbSet))
            {
                if (dbSet.ToLower() != "true")
                {
                    return RedirectToAction("Sys", "Home");
                }
            }
            // DO the patch herevar 
            string conSec = WebConfigurationManager.ConnectionStrings["inout_db"].ConnectionString;
            bool updateSuccess = AppInstallation.PatchDatabase(conSec);
//            if (updateSuccess)
//            {
                var webConfig = WebConfigurationManager.OpenWebConfiguration("~");
                var dbPatch = webConfig.AppSettings.Settings["patchDb"];
                if (dbPatch != null)
                {
                    dbPatch.Value = "false";
//                    webConfig.AppSettings.Settings.Add(new KeyValueConfigurationElement("dbPatch", "false"));
                    webConfig.Save(ConfigurationSaveMode.Modified);
                }
                return RedirectToAction("Index");
//            }




//            ViewBag.Message = "Database Patch did not complete Successfully!";
//            return View("PatchDb")

        }
    }

    public class DatabaseConfigModel
    {
        public string serverName { get; set; }
        public string databaseName { get; set; }
        public string userId { get; set; }
        public string password { get; set; }
    }
}