using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models.Navigation;

namespace asom.apps.web.inOut.Controllers
{
  public class FrontEndController : BaseController
  {
    // GET: FrontEnd
    public ActionResult Index()
    {
      var setup = WebConfigurationManager.AppSettings["setupInit"];
      if (!string.IsNullOrEmpty(setup))
      {
        if (setup.ToLower() == "false")
        {
          return RedirectToAction("index", "Setup");
        }
      }
      var dbSet = WebConfigurationManager.AppSettings["patchDb"];
      if (!string.IsNullOrEmpty(dbSet))
      {
        if (dbSet.ToLower() == "true")
        {
          return RedirectToAction("PatchDatabase", "Setup");
        }
      }
      ViewBag.SelectedMenu = WebConstants.HOME_MENU;
      ViewBag.PageTitle = "Welcome";
      ViewBag.PageDescription =
        "Get Grants for Business, schools and welfares!!";
      return View();
    }

    public ActionResult Faq()
    {

      ViewBag.SelectedMenu = WebConstants.FAQ;
      ViewBag.PageTitle = "Faq (Frequently Asked Questions)";
      ViewBag.PageDescription = "Financial Help, Crypto Investment, how to make money with bitcoin";
      return View();
    }

 

    public ActionResult Blog()
    {

      ViewBag.SelectedMenu = WebConstants.BLOG;
      return View();
    }
  public ActionResult Contact()
    {

      ViewBag.SelectedMenu = WebConstants.CONTACT;
      return View();
    }
//    [ActionName("terms-and-condition")]
    public ActionResult Terms()
    {
      ViewBag.PageTitle = "Our Terms & Conditions";
      ViewBag.PageDescription = "Terms & conditions, Please read carefully";
      ViewBag.SelectedMenu = WebConstants.ABOUT_MENU;
      return View();
    }


    ActionResult CheckIfSetupIsCompleted()
    {
      var setup = WebConfigurationManager.AppSettings["setupInit"];
      if (!string.IsNullOrEmpty(setup))
      {
        if (setup.ToLower() == "false")
        {
          return RedirectToAction("index", "Setup");
        }
      }
      var dbSet = WebConfigurationManager.AppSettings["patchDb"];
      if (!string.IsNullOrEmpty(dbSet))
      {
        if (dbSet.ToLower() == "true")
        {
          return RedirectToAction("PatchDatabase", "Setup");
        }
      }

      return Content("Hello");
    }
  }
}
