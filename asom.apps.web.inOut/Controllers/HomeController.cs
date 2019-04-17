using System;
using System.Linq;
using System.Security.Authentication;
using System.Threading;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using asom.apps.inOut.core.model.authentication;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using asom.apps.web.inOut.Models.Navigation;
using asom.apps.web.inOut.Models.Settings;
using itrex.businessObjects.model.core;
using MailKit.Net.Smtp;
using MimeKit;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Controllers
{
    [Authorize]
    public class HomeController : SecuredAppController
    {
        public HomeController()
        {
            // Check

        }
       
        /*[AllowAnonymous]
        public ActionResult Register()
        {
            return View("~/Views/Auth/register.cshtml");
        }
        [AllowAnonymous]
        [HttpPost]
        public ActionResult Register(string userInfo)
        {
            return View("~/Views/Auth/register.cshtml");
        }*/
        [AllowAnonymous]
        [HttpPost]
        public ActionResult ActivateUser(string uid, string code)
        {
            if (!string.IsNullOrEmpty(uid) && !string.IsNullOrEmpty(code))
            {
                // Check if the user id is Valid and also check the Activation code assigned
                var userCrud= IdentityStore.GetIdentity(uid);
                if (userCrud.IsSuccess)
                {
                    IdentityStore id = userCrud.Data;
                    if (id.ActivationCode.ToLower() == code.ToLower())
                    {
                        // valid only when user has email
                        if (!string.IsNullOrEmpty(id.Email))
                        {
                            //Success Achieved
                            id.UnBlockUser();
                        }
                    }
                    else
                    {
                         return View("~/Views/Auth/index.cshtml");
                    }
                }
                else
                {
                     return View("~/Views/Auth/index.cshtml");
                }
            }
            else
            {
                return View("~/Views/Auth/index.cshtml");
            }
            return View("~/Views/Auth/register.cshtml");
        }
        [AllowAnonymous]
        [HttpGet]
        public ActionResult ActivateAccount(string uid, string code)
        {
            // Perform Account Action
            // If Successfull,
            // Return login Page
            bool success = false;
            bool userExits = IdentityStore.IdentityExist(uid);
            if (userExits)
            {
                if (!IdentityStore.IsActivatedFor(uid))
                {
                    var user = IdentityStore.GetIdentity(uid).Data;
                    if (user.IsOn == false && user.ActivationCode.ToLower() == code.ToLower())
                    {
                        // activate user
                        success = IdentityStore.ActivateUser(uid);
                        if (success)
                        {
                            // Redirect to login page for authentication
                            ViewBag.activated = true;

                            //                            return RedirectToAction("Index");
                        }
                    }
                }


            }

            // check if the User Exist




            return View("~/Views/auth/activateAccount.cshtml");
        }
        [AllowAnonymous]
        [HttpGet]
        public ActionResult Login()
        {

            return RedirectToAction("Index");
        }
        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(string userId, string password, bool remember=false, bool isXhr = false)
        {
            IdentityStore uc = new IdentityStore();
            uc.Id = userId;
            uc.Password = password;

            Authenticator.OnAuthenticate += (object o,AuthenticateEventArg e) =>
            {
                 if (e.IsSuccess)
                 {
                     try
                     {
                         if (!isXhr)
                         {

                            Session.Clear();
                             UserIdentityModel model = e.CurrentUser;
                             FormsAuthentication.SetAuthCookie(e.CurrentUser.Key, remember);
                             IdentitySession.SetUser(model);
                         }


                     }
                     catch (Exception)
                     {


                     }

                }
            };

           bool res =  Authenticator.Authenticate(uc.Key, uc.Password, out uc);
            if (res)
            {
                if (!isXhr)
                {
                    return RedirectToAction("Sys");
                }
                else
                {
                    return SuccessAction("Login successful" ,  null);
                }

            }
            return RedirectToAction("Index");
        }
        /// <summary>
        /// This will return the Default Home page with a Login Component
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
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

            return View("~/Views/Auth/index.cshtml");
        }

        public ActionResult Sys()
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

            //AppConfig.GetInstance().SetCurrentUserFromThread(User);
            return View("index");
        }
//       [OutputCache(Duration = 3000000)]
//        public ActionResult GetThemes()
//        {
//            var data = new
//            {
//                data  = ThemeSetting.GetAvailableThemesAsJSON(),
//                success  = true
//            };
//            return MyConfig.DefaultJsonResult(data);
//        }
        [OutputCache(Duration = 3000000)]
        protected ActionResult GetAllThemes()  // index 200
        {

            return Content(ThemeSetting.GetAvailableThemesAsJSON());
        }
        [ActionName("app-theme")]
        protected ActionResult GetSelectedAppTheme() // index 0f 100
        {
            // get current App Theme
            SettingModel sm = OrganizationInfo.GetSettings();
            string res = "";
            var theme = ThemeSetting.GetAvailableThemes().FirstOrDefault(x => x.Name == sm.AppThemeName) ;
            var data = new
            {
                data = theme,
                success  = theme != null
            };
            return Content(JsonConvert.SerializeObject(data, MyConfig.DefaultJsonSettings));
        }
        [AllowAnonymous]
        [ActionName("save-app-theme")]
        protected ActionResult SaveAppTheme(string theme)  // 300
        {
            // TODO : Check User Permission Here
            if (!User.Identity.IsAuthenticated)
            {
                return this.AuthenticationRequiredAction;
            }
            // Deserialize the theme
            var objtheme = JsonConvert.DeserializeObject<Themes>(theme, MyConfig.DefaultJsonSettings);
           // Session["theme"] = objtheme;
            OrgAppSetting settings = OrganizationInfo.GetSettings();
            settings.AppThemeName = objtheme.Name;
            settings.UpdateSettings();
            var data = new
            {
                data = theme,
                success  = true
            };
            return MyConfig.DefaultJsonResult(data);
        }



        public ActionResult GetMenus(bool getActive= false)
        {
            var result = JsonConvert.SerializeObject(getActive ?MenuManager.GetActiveMenu()
                :MenuManager.GetApplicationMainMenu(),
                MyConfig.DefaultJsonSettings);
            var data = new
            {
                message = "All Menu retured",
                success = true,
                data = result
            };
            return MyConfig.DefaultJsonResult(data);
        }

        [ActionName("themesUrl")]
        public ActionResult GetThemesUrl(int? key, string data)
        {
            switch (key)
            {
                case 100:
                    // Get the selected theme for this app
                    return GetSelectedAppTheme();
                    break;
                case 200:
                    // return all themes
                    return GetAllThemes();
                    break;
                case 300:
                    // save theme url, we expect data to be passed
                    return SaveAppTheme(data);
                    break;
                case 400:
                    // save theme url, we expect data to be passed
                    return SendTestEmail(data);
                    break;
            }
            return FailedAction("Could not Result");
        }

    protected ActionResult SendTestEmail(string content)
    {
      ServerResponseModel res = new ServerResponseModel();
      res.Message = "Could not Sent Test Email";
      res.Success = false;
      try
      {

            try
            {
              IEmailSettings email = OrgAppSetting.GetEmailSettings();
              if (email.SendEmail == true)
              {
                if (!string.IsNullOrEmpty(email.SmtpPassword) && !string.IsNullOrEmpty(email.SmtpUserId) &&
                    !string.IsNullOrEmpty(email.SmtpServerAddress) &&
                    !string.IsNullOrEmpty(email.SmtpPortNumber))
                {
                  string body = content;
                  MimeMessage msg = new MimeMessage();
                  msg.From.Add(new MailboxAddress(email.SmtpUserId));
                  msg.To.Add(new MailboxAddress("alfredcsdinc@gmail.com"));
                  msg.Subject = "DO NOT REPLY, TESTING Email Functionality on Site";
                  msg.Body = new TextPart("html")
                  {
                    Text = body
                  };


                  Thread t = new Thread(new ThreadStart((() =>
                  {
                    using (var client = new SmtpClient())
                    {

                      //client.SslProtocols  = SslProtocols.Default;
                      client.AuthenticationMechanisms.Remove("XOAUTH2");
                      // For demo-purposes, accept all SSL certificates (in case the server supports STARTTLS)
                      client.ServerCertificateValidationCallback = (s, c, h, e) => true;

                      client.Connect(email.SmtpServerAddress.Trim(), int.Parse(email.SmtpPortNumber.Trim())/*, Properties.Settings.Default.useHttps*/);

                      // Note: only needed if the SMTP server requires authentication
                      client.Authenticate(email.SmtpUserId.Trim(), email.SmtpPassword.Trim());

                      client.Send(msg);
                      client.Disconnect(true);
                    }

                  })));
                  t.Start();

                  res.Message =
                    "Email Sent Please check to see if an Email was sent to the Email Address : alfredcsdinc@gmail.com";
                  res.Success = true;
                  res.Data = content;
                  //

                }



              }
            }

            catch (Exception err)
            {

              //throw;
            }



      }
      catch (Exception err)
      {
        res.Message = "Internal Server Error occured during registration!";
        res.ServerException = err;
      }


      // send Email

      return CrudOperaResult(res);
    }
    public ActionResult Logout()
        {
            LogOutUser();
            return RedirectToAction("Index","FrontEnd");
        }

        void LogOutUser()
        {
            AppConfig.GetInstance().CurrentUser = null;
            IdentitySession.Clear();
            Session.Clear();
            FormsAuthentication.SignOut();
        }
      [AllowAnonymous]
      public ActionResult ForgotPassword()
      {
        return View("~/Views/Auth/forgotPassword.cshtml");
      }
  }
}
