using System.Collections.Generic;
using System.Web.Mvc;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models.Navigation;

namespace asom.apps.web.inOut.Controllers
{
    public class MenuController : BaseController
    {
        // GET: Menu
        [ActionName("find-submenu")]
       // [OutputCache(Duration = 120,VaryByParam = "id")]
        public ActionResult FindSubMenusOfMainMenu(string id="Dashboard")
        {
            IEnumerable<SubMenuHeader> res = MenuManager.BuildSubMenusFor(id);
            return PartialView("ui/menu/left/_leftMenu",res);
        }
    }
}