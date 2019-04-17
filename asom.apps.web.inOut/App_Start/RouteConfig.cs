using System.Web.Mvc;
using System.Web.Routing;

namespace asom.apps.web.inOut
{
  public class RouteConfig
  {
    public static void RegisterRoutes(RouteCollection routes)
    {
      routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
      routes.MapRoute(
        name: "FrontEndHOME",
        url: "",
        defaults: new {controller = "FrontEnd", action = "index"}
      );
      routes.MapRoute(
        name: "FrontEnd",
        url: "index",
        defaults: new {controller = "FrontEnd", action = "index"}
      );
      routes.MapRoute(
        name: "FrontEnd_About",
        url: "about",
        defaults: new {controller = "FrontEnd", action = "about"}
      );
       routes.MapRoute(
        name: "FrontEnd_CONTACT",
        url: "contact-us",
        defaults: new {controller = "FrontEnd", action = "contact"}
      );
      routes.MapRoute(
        name: "FrontEnd_LOGIN",
        url: "login",
        defaults: new {controller = "FrontEnd", action = "login"}
      );
      routes.MapRoute(
        name: "FrontEnd_getStarted",
        url: "blog",
        defaults: new {controller = "FrontEnd", action = "blog"}
      );
      routes.MapRoute(
        name: "SysSetup",
        url: "setup",
        defaults: new {controller = "Setup", action = "index"}
      );
      routes.MapRoute(
        name: "Sys",
        url: "Sys/{action}/{id}",
        defaults: new {controller = "Home", action = "sys", id = UrlParameter.Optional}
      );

      routes.MapRoute(
        name: "Auth",
        url: "Auth/{action}/{id}",
        defaults: new {controller = "Home", action = "Index", id = UrlParameter.Optional}
      );
      routes.MapRoute(
        name: "Default",
        url: "{controller}/{action}/{id}",
        defaults: new {controller = "Setup", action = "Index", id = UrlParameter.Optional}
      );
    }
  }
}
