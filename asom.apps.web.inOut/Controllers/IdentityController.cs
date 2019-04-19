using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Authentication;
//using System.Net;
//using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using asom.apps.inOut.core;
using asom.apps.inOut.core.model.authentication;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.OpenModel;
using itrex.businessObjects.model.core.securables;
using Microsoft.Security.Application;
using MimeKit;
using  MailKit.Net.Smtp;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Controllers
{
    public class IdentityController : SecuredAppController
    {
        // GET: Identity
        private const  int UPDATE_FIELDS = 1;
        private const int UPDATE_ALL = 2;
        private const int CREATE_NEW = 200;
        private const int CREATE_SYSADMIN= 10;
        private const int IS_AUTHETICATED = 4;
        private const int GET_CURRENT_USER = 5;
        private const int GET_USER_IDENTITY = 6;
        private const int GET_USER_IDENTITIES = 7;
        private const int UPDATE_USER_PREFERENCE = 8;
        private const int GET_INSTALLED_ROLES_WITH_CRITERIA = 1000;
        private const int GET_ALL_INSTALLED_ROLES = 1001;
        private const int GET_ALL_INSTALLED_ROLE_NAMES = 1002;
        private const int CREATE_CUSTOM_ROLE = 2000;
        private const int INSTALL_SYS_ROLES = 3000;
        private const int GET_ALL_CUSTOM_PERMISSION = 3001;
        private const int GET_SALES_CUSTOM_PERMISSION = 3002;
        private const int GET_INVENTORY_CUSTOM_PERMISSION = 3003;
        private const int GET_CRM_CUSTOM_PERMISSION = 3004;
        private const int GET_ACCOUNTANT_CUSTOM_PERMISSION = 3005;
        private const int GET_SYSCONFIG_CUSTOM_PERMISSION = 3006;
        private const int BLOCK_USER = 700;
        private const int UNBLOCK_USER = 701;
        private const int CHANGE_USER_PASSWORD = 702;
        private const int DELETE_USER = 703;
        private const int GET_USER_NAME = 705;
        private const int REGISTER_NEW_USER = 10000;
        private const int FORGOT_PASSWORD = 501;
        // and so on


        [HttpPost]
        public ActionResult UpdateIdentityField(string data, string criteria)
        {
            /*
                We expect criteria to be of type IdentityStoreCriteria and the id property should be the id of
                the current user
            */
            try
            {
                if (!User.Identity.IsAuthenticated)
                {
                    return FailedAction("You are not authenticated");
                }
                if (!string.IsNullOrEmpty(criteria))
                {
                    UserIdentityModel idm =
                        JsonConvert.DeserializeObject<UserIdentityModel>(data, MyConfig.DefaultJsonSettings);
                    IdentityStoreCriteria cri = JsonConvert.DeserializeObject<IdentityStoreCriteria>(criteria,
                        MyConfig.DefaultJsonSettings);
                    if (cri != null && idm != null)
                    {
                        // we have a valid value
                        string userId = cri.Id;
                        //Get Identity ;

                        var crud = IdentityStore.GetIdentity(userId);
                        if (crud.IsSuccess)
                        {
                            IdentityStore id = crud.Data;
                            id.PictureUrl = idm.PictureUrl;
                            // Update The model to reflect in session
                            UserIdentityModel res = crud.Data;

                            IdentitySession.UpdateUser(res);
                            if (cri.UpdateDisplayName)
                            {
                                crud = ((IdentityStore)idm).UpdateObjectFields(cri);
                            }
                            else
                            {
                                crud = id.UpdateObjectFields(cri);
                            }

                            crud.Data = null;
                        }
                        string result =
                            JsonConvert.SerializeObject(ServerResponseModel.From(crud), MyConfig.DefaultJsonSettings);
                        return Content(result);
                    }
                }
            }
            catch (Exception err)
            {
                return FailedAction(err.Message);

            }

            return FailedAction("Could not validate criteria");
        }

        [HttpPost]
        protected ActionResult CreateSysAdminLogin(string data )
        {
            /*
                We expect criteria to be of type IdentityStoreCriteria and the id property should be the id of
                the current user
            */
            try
            {
                if (SuperAdminIdentity.IsAnySuperAdminAccountStored)
                {
                    new OrganizationInfo().SaveRecord();
                    return SuccessAction("A System Admin Account is already created!");
                }
                if (!string.IsNullOrEmpty(data))
                {
                    LoginInfoModel idm = JsonConvert.DeserializeObject<LoginInfoModel>(data, MyConfig.DefaultJsonSettings);

                    if (idm != null)
                    {

                        if (string.IsNullOrEmpty(idm.DisplayName))
                        {
                            idm.DisplayName = "System Admin";
                        }
                        if (idm.UserId.Length < 6)
                        {
                            return FailedAction("User Id Must Exceed 5 characters length and cannot contain symbols or spaces. Please Try again");
                        }
                        string res = idm.UserId.ToLower();
                        const string regExPattern = @"[A-Za-z]+[A-Za-z0-9]+";

                        Regex reg = new Regex(regExPattern, RegexOptions.IgnoreCase | RegexOptions.Singleline);
                        var newMatch = reg.Match(res);
                        if (!newMatch.Success)
                        {
                            return FailedAction("A valid User Id can only contain letters and numbers. Please Try again");
                        }
                        //Helper.GetPrettyUrlId("rrr");
                        if ((idm.Password1 != idm.Password2))
                        {
                            return FailedAction("Password Must match and must exceed 5 characters. Please Try again");
                        }
                        if (idm.Password1.Length < 6)
                        {
                            return FailedAction("Password Must Exceed 5 characters length. Please Try again");
                        }

                        var crud  = SuperAdminIdentity.CreateNewAdmin(idm.UserId,idm.Password1, idm.DisplayName);
                        if (crud.IsSuccess)
                        {
                            // Authenticate user so that we could create other components that requires authorization
//                            var webConfig = WebConfigurationManager.OpenWebConfiguration("~");
//                            var sectionInit = webConfig.AppSettings.Settings["setupInit"];
                            var webConfig = WebConfigurationManager.OpenWebConfiguration("~");
                            var sectionInit = webConfig.AppSettings.Settings["setupInit"];
                            var sectionPatchDb = webConfig.AppSettings.Settings["patchDb"];
                            if (sectionInit == null)
                            {
                                webConfig.AppSettings.Settings.Add(new KeyValueConfigurationElement("setupInit", "false"));

                            }
                            if (sectionPatchDb == null)
                            {
                                webConfig.AppSettings.Settings.Add(new KeyValueConfigurationElement("patchDb", "true"));
                            }
                            if (sectionInit != null)
                            {
                                sectionInit.Value = "true";
                                webConfig.Save(ConfigurationSaveMode.Modified);
                            }
                            AuthOnce(crud.Data);
                            new OrganizationInfo().SaveRecord();

                            return SuccessAction("System Admin account Created Successfully");
                        }
                    }
                }
            }
            catch (Exception err)
            {
                return FailedAction(err.Message);

            }

            return FailedAction("Could not Create Admin Account Please Try again");
        }

        private void AuthOnce(IdentityStore identity)
        {
            IdentityStore uc = identity;
            bool authYes = Authenticator.Authenticate(uc.Key, uc.Password, out uc);
            if (authYes)
            {
                try
                {
                    Session.Clear();
                    UserIdentityModel model = uc;
                    FormsAuthentication.SetAuthCookie(uc.Key, false);
                    IdentitySession.SetUser(model);
                }
                catch (Exception)
                {
                }
            }
        }

        public ActionResult GetIdentity(string id, bool includePassword = false)
        {
            if (User.Identity.IsAuthenticated)
            {
                ServerResponseModel identity = UserIdentityModel.GetIdentity(id, includePassword);
                return Content(JsonConvert.SerializeObject(identity, MyConfig.DefaultJsonSettings));
            }

            return FailedAction("Not Authenticated");

        }

        public ActionResult GetIdentities(string criteria)
        {
            string failureMsg = "Not Authenticated.";
            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    IdentityStoreCriteria cri = JsonConvert.DeserializeObject<IdentityStoreCriteria>(criteria,
                        MyConfig.DefaultJsonSettings);
                    if (cri != null)
                    {
                        var res  = UserIdentityModel.GetIdentities(cri);
                        return CrudOperaResult(res);
                    }
                }
                catch (Exception err)
                {
                    failureMsg = "Exception Occured : " + err.Message;
                }



            }

            return FailedAction(failureMsg);
        }

//        public ActionResult GetUserNames(string criteria)
//        {
//            string failureMsg = "Not Authenticated.";
//            if (User.Identity.IsAuthenticated)
//            {
//                try
//                {
//                    IdentityStoreCriteria cri = JsonConvert.DeserializeObject<IdentityStoreCriteria>(criteria,
//                        MyConfig.DefaultJsonSettings);
//                    if (cri != null)
//                    {
//                         var res  = UserIdentityModel.GetUserNames(cri);
//                        return CrudOperaResult(res);
//                    }
//                }
//                catch (Exception err)
//                {
//                    failureMsg = "Exception Occured : " + err.Message;
//                }
//
//
//
//            }
//
//            return FailedAction(failureMsg);
//        }
        //5
        public ActionResult GetCurrentIdentity( bool includePassword = false)
        {
            // Get current authenticated Identity
            if (User.Identity.IsAuthenticated)
            {
                ServerResponseModel identity = UserIdentityModel.GetIdentity(User.Identity.Name, includePassword);
                return Content(JsonConvert.SerializeObject(identity, MyConfig.DefaultJsonSettings));
            }

            return FailedAction("Not Authenticated");
        }
        //4
        public ActionResult IsAuthenticated()
        {
            bool isAuth = User.Identity.IsAuthenticated;
            if(isAuth)
                return SuccessAction("User is Authenticated", new {user  = User.Identity.Name});
            else
            {
                return FailedAction("Not Authenticated");
            }
        }

        // 8 Update Preference
        [HttpPost]
        //[ValidateInput(false)]
        protected ActionResult UpdatePreference(string preference)
        {
            if (!string.IsNullOrEmpty(preference))
            {
//                preference = Sanitizer.GetSafeHtml(preference);
                try
                {
                    IdentityPreferenceModel model = JsonConvert.DeserializeObject<IdentityPreferenceModel>(preference,
                        MyConfig.DefaultJsonSettings);
                    IdentityPreference id = (IdentityPreference) model;
                    id.Update();
                    return SuccessAction("Preference Updated!",model);
                }
                catch (Exception err)
                {
                    return FailedAction(err.Message);

                }


            }
            return FailedAction("Update Failed");
        }




        // KEY  = 1000 :remember from our client code
        protected ActionResult GetRolesByCriteria(string criteria)
        {
            try
            {
                IEnumerable<RoleModel> res = new List<RoleModel>();
                // Ensure User is Authenticated
                if (User.Identity.IsAuthenticated)
                {
                    // Not Applicable, because we want users to see roles assigned to them
                    if (!string.IsNullOrEmpty(criteria))
                    {
                        // Convert to role criteria obj
                        RoleCriteria cri = JsonConvert.DeserializeObject<RoleCriteria>(criteria,
                            MyConfig.DefaultJsonSettings);
                        // do we have a valid object?
                        if (cri != null)
                        {
                            res = RoleModel.GetRolesByCriteria(cri);
                        }
                        else
                        {
                            // get all roles instead
                            res = RoleModel.GetAllRoles();
                        }
                    }
                    else
                    {
                        // get all roles instead
                        res = RoleModel.GetAllRoles();
                    }
                    return SuccessAction("All Installed Roles Loaded", res);
                }
                else
                {
                    return AuthenticationRequiredAction;
                }
            }
            catch (Exception err)
            {

                return FailedAction(err.Message);
            }
            return FailedAction("Could not complete your request for Roles Retrival");
        }

        //KEY 1001
        protected ActionResult GetAllRoles()
        {
            try
            {
                IEnumerable<RoleModel> res = new List<RoleModel>();
                // Ensure User is Authenticated
                if (User.Identity.IsAuthenticated)
                {

                    // get all roles instead
                    res = RoleModel.GetAllRoles().Select(x => RoleModelExtension.From(x));

                    return SuccessAction("All Installed Roles Loaded", res);
                }
                else
                {
                    return AuthenticationRequiredAction;
                }
            }
            catch (Exception err)
            {

                return FailedAction(err.Message);
            }
            return FailedAction("Could not complete your request for Roles Retrival");
        }
        protected ActionResult GetAllRolesNames()
        {
            try
            {
                IEnumerable<RoleModel> res = new List<RoleModel>();
                // Ensure User is Authenticated
                if (User.Identity.IsAuthenticated)
                {

                    // get all roles instead
                    res = RoleModel.GetRolesByCriteria(new RoleCriteria() {GetRoleNames = true});

                    return SuccessAction("All Roles Names retured", res);
                }
                else
                {
                    return AuthenticationRequiredAction;
                }
            }
            catch (Exception err)
            {

                return FailedAction(err.Message);
            }
            return FailedAction("Could not complete your request for Roles Retrival");
        }


        [HttpPost]
        protected ActionResult InstallSystemRoles()
        {
            try
            {

                bool success  = AppRoleName.InstallSystemRoles(true);
                if (success)
                {
                    return SuccessAction("All Roles and System Security Component were Installed Successfully");
                }



            }
            catch (Exception err)
            {

                return FailedAction(err.Message);
            }

            return FailedAction("Role Failed to Install. Connection String is : " + AppConfig.ConnectionString);
        }
        // Key  = 200
        [HttpPost]
        protected ActionResult CreateNewUser(string userIdentityModel, string listOfRoles, string currentUserPassword)
        {

            ServerResponseModel res  = new ServerResponseModel();
            res.Message = "Could NOT COMPLETE!";
            res.Success = false;
            // we expect the userInfo and List of roles for this user
            try
            {
                if (User.Identity.IsAuthenticated)
                {
                    // check current user account password!
                    var crud = IdentityStore.GetIdentity(IdentitySession.GetOrCreate().UserId);
                    if (crud.IsSuccess)
                    {
                        if (crud.Data.Password == currentUserPassword)
                        {
                            // We are Good to proceed!
                            if (!string.IsNullOrEmpty(userIdentityModel) && !string.IsNullOrEmpty(listOfRoles))
                            {
                                UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userIdentityModel,
                                    MyConfig.DefaultJsonSettings);
                                IEnumerable<M_RoleModel> roles = JsonConvert.DeserializeObject<IEnumerable<M_RoleModel>>(listOfRoles,
                                    MyConfig.DefaultJsonSettings);

                                // let do the creation here!
                                res = UserIdentityModel.CreateNewIdentity(user, roles.Select(x => (RoleModel)x));
                                return CrudOperaResult(res);

                            }
                            else
                            {
                                return
                                    FailedAction(
                                        "You did not supply the required data for this action. You must select at least on role for this user!");

                            }
                        }
                        else
                        {
                            // Authentication failed!  ABORT!
                            // we may want to send number of allowed trials here in other to logout the user
                            return FailedAction("Invaild user Password Entered. Please try again!");
                        }
                    }



                }
                else
                {
                    return AuthenticationRequiredAction;
                }

            }
            catch (Exception err)
            {
                res.Message = "An Error Occured on the server, Please view Error Logs for details!";
                res.ServerException = err;

            }

            return CrudOperaResult(res);
        }

        // key = 60
        protected ActionResult GetUserPassword(string userId, string currentUserPassword)
        {
            if (User.Identity.IsAuthenticated)
            {
                if (!string.IsNullOrEmpty(currentUserPassword))
                {
                    var crud = IdentityStore.GetIdentity(IdentitySession.GetOrCreate().UserId);
                    if (crud.IsSuccess)
                    {
                        if (crud.Data.Password == currentUserPassword)
                        {
                            // check if the user has certain permission to view other user passwords
                            var id = new IdentityStore().HasAuthority(AppPermissions.AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE);
                            if (id)
                            {
                                var usr = IdentityStore.GetIdentity(userId);
                                if (usr.IsSuccess)
                                {
                                    return SuccessAction("Password retreived!", usr.Data.Password);
                                }
                                else
                                {
                                    return FailedAction("User account was not found. Aborting request!");
                                }
                            }
                        }
                    }
                }
                else
                {
                    return FailedAction("You are not Authorized. Please supply your password for verification!");
                }
            }
            else
            {
                return AuthenticationRequiredAction;
            }
            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }

        [HttpPost]
        protected ActionResult ChangeUserPassword(string userId, string oldPassword, string newPassword)
        {
            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    if (!string.IsNullOrEmpty(userId))
                    {
//                       UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userId  ,  MyConfig.DefaultJsonSettings);
                        // so lets do the magic
                        ServerResponseModel res  = UserIdentityModel.ChangeUserIdentityPassword(userId, oldPassword, newPassword);
                        return CrudOperaResult(res);
                    }
                    else
                    {
                        return FailedAction("Invalid User Profile Data Supplied. Please ensure you selected a user before performing this action");
                    }
                }
                catch (Exception err)
                {

                    FailedAction("Server Input Error Occured! Action ->  'Change Password'");
                }
            }
            else
            {
                return AuthenticationRequiredAction;
            }
            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }

        [HttpPost]
        protected ActionResult ForgotPasswordProcess(string userId, string emailAddress)
        {

            try
            {
                if (!string.IsNullOrEmpty(userId) && !string.IsNullOrEmpty(emailAddress))
                {
                    //                       UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userId  ,  MyConfig.DefaultJsonSettings);
                    // so lets do the magic
                    ServerResponseModel res = UserIdentityModel.ForgotPasswordProcess(userId, emailAddress);
                    return CrudOperaResult(res);
                }
                else
                {
                    return FailedAction("Invalid User Profile Data Supplied. User Id and Email address are required to complete this process");
                }
            }
            catch (Exception err)
            {

                FailedAction("Server Input Error Occured! Action ->  'Change Password'");
            }

            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }
        [HttpPost]
        protected ActionResult DeleteUser(string userModel, string currentUserPassword)
        {
            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    var crud = IdentityStore.GetIdentity(IdentitySession.GetOrCreate().UserId);
                    if (crud.IsSuccess)
                    {
                        if (crud.Data.Password == currentUserPassword)
                        {
                            // We are Good to proceed!
                            if (!string.IsNullOrEmpty(userModel))
                            {
                                UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userModel,
                                    MyConfig.DefaultJsonSettings);
                                var mmm = UserIdentityModel.DeleteUserIdentity(user);
                                return CrudOperaResult(mmm);
                            }
                            else
                            {
                                return
                                    FailedAction(
                                        "You did not supply the required data for this action. You must select at least on role for this user!");

                            }
                        }
                        else
                        {
                            // Authentication failed!  ABORT!
                            // we may want to send number of allowed trials here in other to logout the user
                            return FailedAction("Invaild user Password Entered. Please try again!");
                        }
                    }

                }
                catch (Exception err)
                {

                    FailedAction("Server Input Error Occured! Action ->  'Block USER CALLED'");
                }
            }
            else
            {
                return AuthenticationRequiredAction;
            }
            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }
        [HttpPost]
        protected ActionResult BlockUser(string userId, string currentUserPassword)
        {
            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    var crud = IdentityStore.GetIdentity(IdentitySession.GetOrCreate().UserId);
                    if (crud.IsSuccess)
                    {
                        if (crud.Data.Password == currentUserPassword)
                        {
                            // We are Good to proceed!
                            if (!string.IsNullOrEmpty(userId))
                            {
//                                UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userId,
//                                    MyConfig.DefaultJsonSettings);
                                var mmm = UserIdentityModel.BlockUserIdentity(userId);
                                return CrudOperaResult(mmm);
                            }
                            else
                            {
                                return
                                    FailedAction(
                                        "You did not supply the required data for this action. You must select at least on role for this user!");

                            }
                        }
                        else
                        {
                            // Authentication failed!  ABORT!
                            // we may want to send number of allowed trials here in other to logout the user
                            return FailedAction("Invaild user Password Entered. Please try again!");
                        }
                    }

                }
                catch (Exception err)
                {

                    FailedAction("Server Input Error Occured! Action ->  'Block USER CALLED'");
                }
            }
            else
            {
                return AuthenticationRequiredAction;
            }
            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }
        [HttpPost]
        protected ActionResult UnBlockUser(string userId, string currentUserPassword)
        {
            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    var crud = IdentityStore.GetIdentity(IdentitySession.GetOrCreate().UserId);
                    if (crud.IsSuccess)
                    {
                        if (crud.Data.Password == currentUserPassword)
                        {
                            // We are Good to proceed!
                            if (!string.IsNullOrEmpty(userId))
                            {
//                                UserIdentityModel user = JsonConvert.DeserializeObject<UserIdentityModel>(userId,
//                                    MyConfig.DefaultJsonSettings);
                                var mmm = UserIdentityModel.UnBlockUserIdentity(userId);
                                return CrudOperaResult(mmm);
                            }
                            else
                            {
                                return
                                    FailedAction(
                                        "You did not supply the required data for this action. You must select at least on role for this user!");

                            }
                        }
                        else
                        {
                            // Authentication failed!  ABORT!
                            // we may want to send number of allowed trials here in other to logout the user
                            return FailedAction("Invaild user Password Entered. Please try again!");
                        }
                    }

                }
                catch (Exception err)
                {

                    FailedAction("Server Input Error Occured! Action ->  'Block USER CALLED'");
                }
            }
            else
            {
                return AuthenticationRequiredAction;
            }
            return FailedAction("Authorization FAILED. Please supply a valid password for verification!");
        }

        protected ActionResult PatchDb()
        {
            ServerResponseModel res  =  new ServerResponseModel();
            res.Success = false;
            res.Message = "Failed to set Database to Patching Mode.";
            if (!User.Identity.IsAuthenticated)
            {
                res.Message = "Please Login to complete this action.";
                return CrudOperaResult(res);
            }
            try
            {
                // Ensure the user has the required permission
                bool hasAccess   = new IdentityStore().HasAuthority(new
                    string[] {AppPermissions.MANAGE_APP_SETTINGS, AppPermissions.APP_BACKUP_UPDATE_APPLICATION_FUNCTIONS} , PermissionValidationOperators.OR);
                if (hasAccess)
                {
                    var setup = WebConfigurationManager.AppSettings["setupInit"];
                    if (!string.IsNullOrEmpty(setup))
                    {
                        if (setup.ToLower() != "true")
                        {
                            res.Message = "Please Run Setup first.";
                            return CrudOperaResult(res);
                        }
                    }
//            var dbSet = WebConfigurationManager.AppSettings["patchDb"];
//            if (!string.IsNullOrEmpty(dbSet))
//            {
                    var webConfig = WebConfigurationManager.OpenWebConfiguration("~");

                    var sectionPatchDb = webConfig.AppSettings.Settings["patchDb"];

                    if (sectionPatchDb != null)
                    {
                        sectionPatchDb.Value = "true";
                        webConfig.Save(ConfigurationSaveMode.Modified);

                    }
                    else
                    {
                        webConfig.AppSettings.Settings.Add(new KeyValueConfigurationElement("patchDb", "true"));
                        webConfig.Save(ConfigurationSaveMode.Modified);
                    }
                    FormsAuthentication.SignOut();
                    Session.Clear();
                    res.Success = true;
                    res.Message =
                        "Database Mode has been set to Patching. Please Sign out to start updating your Database.";

                }
                else
                {
                    res.Message = "You are not Authorized to Perform this Action (DATABASE PATCH MODE ON) on the System!";
                    res.Success = false;
                }

            }
            catch (Exception err)
            {

                res.ServerException = err;
                res.Message = $"An Error Occurred! : {err.Message}";
            }


            return CrudOperaResult(res);
        }
        public ActionResult GetDateRanges()
        {
            return SuccessAction("Date Ranges returned", DateRangeHelperModel.GetDateHelpers());
        }
        protected async Task<ActionResult> RegisterUserAsync(string userInfo)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Judge Profile Creation Failed";
            res.Success = false;
            try
            {
                UserIdentityModel id = JsonConvert.DeserializeObject<UserIdentityModel>(userInfo,
                    MyConfig.DefaultJsonSettings);
                if (id != null)
                {
                    string activationCode;
                    res = UserIdentityModel.RegisterUser(id, out activationCode);
                    res.Data = id;
                    if (res.Success)
                    {
                        /*try
                        {
                            IEmailSettings email = OrgAppSetting.GetEmailSettings();
                            if (email.SendEmail == true)
                            {
                                if (!string.IsNullOrEmpty(email.SmtpPassword) && !string.IsNullOrEmpty(email.SmtpUserId) &&
                                    !string.IsNullOrEmpty(email.SmtpServerAddress) &&
                                    !string.IsNullOrEmpty(email.SmtpPortNumber))
                                {
                                    string body = id.GetActivationEmail(activationCode ?? string.Empty);
                                    MimeMessage msg  = new MimeMessage();
                                    msg.From.Add( new MailboxAddress(email.SmtpUserId));
                                    msg.To.Add( new MailboxAddress(id.Email));
                                    msg.Subject = "DO NOT REPLY, Your REGISTRATION was Successful";
                                    msg.Body =  new TextPart("html")
                                    {
                                      Text = body
                                    };



//                                    MailMessage mail = new MailMessage(email.SmtpUserId, id.Email,
//                                        "DO NOT REPLY, Your REGISTRATION was Successful", body);
//                                    mail.IsBodyHtml = true;
//                                    mail.Priority  = MailPriority.High;
//                  mail.DeliveryNotificationOptions =  DeliveryNotificationOptions.OnSuccess;
//                   SmtpClient smtp = new SmtpClient(email.SmtpServerAddress,
//                                        int.Parse(email.SmtpPortNumber));
////                  smtp.EnableSsl =Properties.Settings.Default.useHttps;
//                    smtp.Credentials = new NetworkCredential(email.SmtpUserId, email.SmtpPassword);
//                      smtp.UseDefaultCredentials = true;
                 //  var task = smtp.SendMailAsync(mail);


                                    Thread t = new Thread(new ThreadStart((() =>
                                    {
                                      using (var client = new SmtpClient ()) {

                                        client.AuthenticationMechanisms.Remove ("XOAUTH2");
                                        ///client.SslProtocols  = SslProtocols.Default;
                                        // For demo-purposes, accept all SSL certificates (in case the server supports STARTTLS)
                                        client.ServerCertificateValidationCallback = (s,c,h,e) => true;
                                        client.Connect (email.SmtpServerAddress.Trim(), int.Parse(email.SmtpPortNumber.Trim())/*,Properties.Settings.Default.useHttps#1#);

                                        // Note: only needed if the SMTP server requires authentication
                                        client.Authenticate (email.SmtpUserId.Trim(), email.SmtpPassword.Trim());

                                        client.Send (msg);
                                        client.Disconnect (true);
                                      }
//                                      smtp.EnableSsl =  Properties.Settings.Default.useHttps;
//                                        smtp.Credentials = new NetworkCredential(email.SmtpUserId, email.SmtpPassword);
//                                        smtp.Send(mail);
                                           // var task = smtp.SendMailAsync(mail);

                                    })));
                                    t.Start();

                                    //                                    SmtpClient smtp = new SmtpClient(email.SmtpServerAddress,
                                    //                                        int.Parse(email.SmtpPortNumber));
                                    //                                        smtp.Credentials = new NetworkCredential();
                                    //                                        smtp.SendMailAsync(mail);
                                    res.ExtraData = body;
                                    //

                                }



                            }
                        }

                        catch (Exception err)
                        {

                            //throw;
                        }*/

                    }



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

        protected ActionResult RegisterUser(string userInfo)
        {
            ServerResponseModel   res  =  new ServerResponseModel();
            res.Message = "Registration Complete";
            res.Data = userInfo;
            return CrudOperaResult(res);
        }

        public override async Task<ActionResult> GetUrlAsync(int? key, string data, string criteria, string extradata = null, bool trueFalse = false)
        {
            switch (key)
            {
                case REGISTER_NEW_USER:
                    return await RegisterUserAsync(data);
                
            }
            return await base.GetUrlAsync(key, data, criteria, extradata, trueFalse);
        }

        public override ActionResult GetUrl(int? key,  string data, string criteria, string extradata = null,
            bool trueFalse = false)
        {
            try
            {
                switch (key)
                {
                    case UPDATE_FIELDS:
                        return UpdateIdentityField(data, criteria);

                    case IS_AUTHETICATED:
                        return IsAuthenticated();

                    case GET_CURRENT_USER:
                        return GetCurrentIdentity(trueFalse);

                    case GET_USER_IDENTITY:
                        return GetIdentity(data, trueFalse);

                    case GET_USER_IDENTITIES:
                        return GetIdentities(criteria);
                    case UPDATE_USER_PREFERENCE:
                        return UpdatePreference(data);
                    // ROLES

                    case GET_ALL_INSTALLED_ROLES:
                        return GetAllRoles();

                    case GET_ALL_INSTALLED_ROLE_NAMES:
                        return GetAllRolesNames();

                    case GET_INSTALLED_ROLES_WITH_CRITERIA:
                        return GetRolesByCriteria(criteria);
                    case INSTALL_SYS_ROLES:
                        return InstallSystemRoles();
                    case CREATE_SYSADMIN:
                        return CreateSysAdminLogin(data);
                    case CREATE_NEW:
                        return CreateNewUser(data, criteria, extradata);
                    case 60:
                        return GetUserPassword(data, criteria);
//                    case REGISTER_NEW_USER:
//                        return  RegisterUserAsync(data);

                    case 2000:
                        return GetDateRanges();
                    case BLOCK_USER:
                        return BlockUser(data, criteria);
                    case UNBLOCK_USER:
                        return UnBlockUser(data, criteria);
                    case DELETE_USER:
                        return DeleteUser(data, criteria);
                    case CHANGE_USER_PASSWORD:
                        return ChangeUserPassword(data, criteria, extradata);
                    //                    case GET_USER_NAME:  // 705
                    //                        return GetUserNames(criteria);
                    case FORGOT_PASSWORD:
                        return ForgotPasswordProcess(data, criteria);
                    case 900:
                        // patch Database
                        return PatchDb();


                }
            }
            catch (Exception err)
            {
                return FailedAction(err.Message);
            }

            return AccessDeniedAction;
        }


    }


    public class LoginInfoModel
    {
        public string  DisplayName { get; set; }
        public string UserId { get; set; }
        public string Password1 { get; set; }
        public string Password2 { get; set; }
    }
}