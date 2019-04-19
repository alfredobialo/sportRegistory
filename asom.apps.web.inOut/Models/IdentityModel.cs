using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Authentication;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using asom.apps.inOut.core;
using asom.apps.inOut.core.model.authentication;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models.Settings;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.LicenseApi;
using itrex.businessObjects.model.core.OpenModel;
using itrex.businessObjects.model.core.securables;
using MailKit.Net.Smtp;
using MimeKit;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Models
{
    //    public class NewUserIdentityModel
    //    {
    //        public string Password { get; set; }
    //        public string UserId { get; set; }
    //        public string DisplayName { get; set; }
    //        public IEnumerable<RoleModel> Roles { get; set; }
    //
    //
    //    }

    public class M_RoleModel
    {
        public M_RoleModel()
        {

        }

        public string Name { get; set; } // Similar to Key
        public string Description { get; set; }
        public bool? IsExpired { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public bool? IsExpirable { get; set; } = false;
        public bool? IsSystemDefined { get; set; }

        public bool? IsAdmin { get; set; }
        public string Id { get; set; }

        public string GroupName { get; set; }

        public bool? IsActive { get; set; }

        public static implicit operator RoleModel(M_RoleModel r)
        {
            RoleModel res  =  new RoleModel();
            res.IsExpired = r.IsExpired;
            res.IsAdmin = r.IsAdmin;
            res.IsActive = r.IsActive;
            res.Description = r.Description;
            res.IsSystemDefined = r.IsSystemDefined;
            res.Name = r.Name;
            res.GroupName = r.GroupName;
            res.Id = r.Id;
            res.ExpirationDate = r.ExpirationDate;


            return res;
        }
    }

    public class IdentitySession
    {
        private static string sesson_key = "inOut_user_identity_session";
       // private static HttpContextBase context;
        static  IdentitySession()
        {
           // context = new HttpContextWrapper(HttpContext.Current);
        }

        public static void Logout()
        {
            AppConfig.GetInstance().CurrentUser = null;
            Clear();
            HttpContext.Current.Session.Clear();
            FormsAuthentication.SignOut();
        }
        public static void SetUser(IUserIdentity user)
        {
            var context = HttpContext.Current;
            var session = context.Session;

            if (user != null)
            {
                if (context.User.Identity.IsAuthenticated)
                {
                    if (session[sesson_key] == null)
                    {
                        session.Add(sesson_key, user);
                    }
                    else
                    {
                        session[sesson_key] = user;
                    }

                }
            }
        }
        /// <summary>
        /// Check if the current User is the Owner of the Account In Session
        /// </summary>

        /// <returns></returns>
        public static bool IsCurrentUserInSession()
        {

            var context = HttpContext.Current;
            bool res = false;
            var ctx = context;
            var session = ctx.Session;
            if (ctx.User != null && ctx.User.Identity.IsAuthenticated)
            {
                if (HasAuthAccount)
                {
                    if (GetUser().UserId == ctx.User.Identity.Name)
                    {
                        res = true;
                    }
                }
            }
            return res;
        }

        public static void UpdateUser(IUserIdentity user)
        {
            var context = HttpContext.Current;
            if (HasAuthAccount)
            {
                var session = context.Session;
                session[sesson_key] = user;
            }
        }

        public static IUserIdentity GetUser()
        {
            var context = HttpContext.Current;
            IUserIdentity acc = null;
            try
            {
                var ctx = context;
                acc = ctx.Session[sesson_key] as IUserIdentity;
            }
            catch (Exception err)
            {


            }
            return acc;
        }
        public static bool HasAuthAccount
        {
            get
            {
                var context = HttpContext.Current;

                bool res = false;
                HttpContext ctx = HttpContext.Current;
                try
                {
                    if (context.Session != null && context.Session[sesson_key] != null)
                    {
                        IUserIdentity acc = ctx.Session[sesson_key] as IUserIdentity;
                        if (acc != null)
                        {
                            res = true;
                        }
                    }
                }
                catch (Exception err)
                {

                    // add to session

                }

                return res;

            }
        }

        public static IUserIdentity GetOrCreate()
        {
            var context = HttpContext.Current;
            var ctx = context;
            IUserIdentity au = null;
            if (ctx.User.Identity.IsAuthenticated)
            {


                if (!HasAuthAccount)
                {
                    if (IdentityStore.IdentityExist(ctx.User.Identity.Name))
                    {
                         SetUser(UserIdentityModel.GetIdentity(ctx.User.Identity.Name,false).Data);
                    }

                }
                au = GetUser();
            }
            else
            {
                FormsAuthentication.SignOut();
            }

            return au;
        }

        internal static void Clear()
        {
            HttpContext ctx = HttpContext.Current;
            ctx.Session.Remove(sesson_key);
        }

    }
    public interface IUserIdentity : IUserContext
    {
        string UserId { get; set; }
        string Password { get; set; }
        string Gender { get; set; }
        bool IsActive { get; set; }
        bool IsBlocked { get; set; }
        string DisplayName { get; set; }
        string ObjType { get; set; }
        string PictureUrl { get; set; }
        string ChannelId { get; set; }

    }
    [Serializable]
    public class UserIdentityModel  :  IUserIdentity
    {

        public static ServerResponseModel RegisterUser(UserIdentityModel user, out string activationCode)
        {
            activationCode = null;
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Registration Failed, Please try again!";
            res.Success = false;
            try
            {
                var mm = UserIdentity.RegisterNewUserInstance(user.UserId, user.Password, user.DisplayName, AppConstants.REGISTERED_USER);
                mm.Gender = user.Gender;
                mm.Location = user.Location;
                mm.State = user.State;
                mm.Email = user.Email ;

                var crud = mm.Create();
                res = ServerResponseModel.From(crud);
                if (crud.IsSuccess)
                {
                    activationCode = crud.Data.ActivationCode;
                    res.Message = "Registration Completed Successfully!";
                    res.Data = (UserIdentityModel)crud.Data;
                    // add user permission automatically
                    if (RoleManager.RoleExistInStore(AppRoleName.STANDARD_USER))
                    {

                        RoleManager.SetUserRole(mm, AppRoleName.StandardUserRole);
                    }
                    //IdentitySession.Logout();
                }




            }
            catch (Exception err)
            {
                res.ServerException = err;
            }

            return res;
        }
        public string GetActivationEmail(string activationCode)
        {

            CompanyInfoModel org = CompanyInfoModel.Get;

            string res = @"
                    <div style='width:85% ;background-color: #fff ;padding  : 30px ; margin:20px ;  border: 2px solid #4c505e; min-height: 400px;'>
  <div style='float: left; margin-right: 30px; width:130px;'>
    <img src='[logo]' alt='[company]' width='100px' />
  </div>
  <div style='float: left; text-align: center'>
    <h1>[company]</h1><br>
    <p ><span>Registration Complete!</span></p>
  </div>

  <div style='clear:both; margin-top:  20px;padding:20px'>
    <h4>
      Congratulations! [userName], Your registration into [company] was Successfull
      <br>
      Please click the link below to activate your account!
      <br><br><br>
      <a href='[activationLink]' style='padding:10px; margin: 10px'>This is your activation link [activationLink]</a>

    </h4>
<br><br />
    <b>Best regards, Team [company]</b>

  </div>

</div>

";

            var routeDic = new RouteValueDictionary();
            routeDic.Add("uid", UserId); routeDic.Add("code", activationCode);
            string activationUrl = MyConfig.GenerateResourceUrlWithDomainName("Sys", "Home", "ActivateAccount", routeDic, RouteTable.Routes);
            res = res.Replace("[userName]", DisplayName);
            res = res.Replace("[company]", org.Name);
            res = res.Replace("[logo]", org.LogoUrl);
            res = res.Replace("[activationLink]", activationUrl);




            return res;
        }


        public string UserId { get; set; }
        public string Password { get; set; }
        public string Type { get; set; }
        public string Gender { get; set; }
        public bool IsActive { get; set; }
        public bool IsBlocked { get; set; }
        public string DisplayName { get; set; }
        public string ObjType { get; set; }
        public string PictureUrl { get; set; }
        public string CreatedBy { get; set; }
        public string PhoneNumber { get; set; }
        public string ChannelId { get; set; }
      public string Department { get; set; }
      public string ExtraData1 { get; set; }
      public string ExtraData2 { get; set; }
      public string ExtraData3 { get; set; }
      public string ExtraData4 { get; set; }
      public string Location { get; set; }
        public string State { get; set; }

        public string Email { get; set; } // Ensure this Unique if assigned

        public bool IsEditMode { get; internal set; }

        public static implicit operator UserIdentityModel(IdentityStore i)
        {
            UserIdentityModel res  =  new UserIdentityModel();
            res.UserId = i.Key;
            res.ChannelId = i.ChannelId;
            res.CreatedBy = i.CreatedBy;
            res.Password = "********";//i.Password;
            res.Gender = i.Gender;
            res.Type = i.ObjType;
            res.PictureUrl = string.IsNullOrEmpty(i.PictureUrl) ?
                AppInfo.Get.DefaultAvarter(i.Gender) :
                MyConfig.GetDefaultUrlWithDomainNameIfEmpty(i.PictureUrl, AppInfo.Get.DefaultAvarter(i.Gender));
            res.IsBlocked = i.IsBlocked;
            res.PhoneNumber = i.PhoneNumber;
            res.IsActive = i.IsOn ?? false;
            res.DisplayName = i.DisplayName;
            res.IsEditMode = true;
            res.Location = i.Location;
            res.State = i.State;
            res.Email = i.Email;
            res.DateCreated = i.DateInitialized;



            res.Preferences = IdentityPreferenceModel.fromEnitity(i.Preferences);
            return res;
        }

        public DateTime? DateCreated { get; set; }

        public IEnumerable<IdentityPreferenceModel> Preferences { get; set; }

        public static explicit operator IdentityStore(UserIdentityModel i)
        {
            IdentityStore res  =  new IdentityStore();
            res. Key= i.UserId;
            res.ChannelId = i.ChannelId;
            res.CreatedBy = i.CreatedBy;
            res.Password = i.Password;
            res.Gender = i.Gender;
            res. ObjType= i.Type;
            res.PictureUrl = MyConfig.RemoveDomainName(i.PictureUrl);
            res.IsBlocked = i.IsBlocked;
            res.PhoneNumber = i.PhoneNumber;
            res.IsOn = i.IsActive ;
            res.Location = i.Location;
            res.State = i.State;
            res.DisplayName = i.DisplayName;
            res.Email = i.Email;
            return res;
        }

        public static ServerResponseModel GetIdentities(IdentityStoreCriteria criteria,bool includePassword = false)
        {
            CrudOperationResult<IEnumerable<IdentityStore>> res  =  IdentityStore.GetIdentity(criteria);
            ServerResponseModel serv = ServerResponseModel.From(res);

            if (res.IsSuccess)
            {
               serv.Data = res.Data.Select(x => (UserIdentityModel) x).ToList();

            }
            return serv;
        }
    public static ServerResponseModel GetUserNames(string userId)
    {
      CrudOperationResult<IdentityStoreName> res = IdentityStore.GetUserName(userId);
      if (res.IsSuccess)
      {
        var data = res.Data;
        res.Data.PictureUrl = MyConfig.GetDefaultUrlWithDomainNameIfEmpty(data.PictureUrl, AppInfo.Get.DefaultAvarter(data.Gender));

      }else
      {

      }
      ServerResponseModel serv = ServerResponseModel.From(res);



      return serv;
    }
    //  Create a new User identity Object
    // this will include a valid userId, Display Name and password
    // also we need to re-authenticate the user person creating this account

    public static ServerResponseModel CreateNewIdentity(UserIdentityModel userInfo, IEnumerable<RoleModel> roles)
        {
            ServerResponseModel  res  =  new ServerResponseModel();
            res.Message = "Could not Complete Your Request!";
            res.Success = false;
            res.IsAuthorize = true;
            res.Data = userInfo;
            res.ExtraData = roles;

            //TODO :  Validate The Number of Users allowed for this user License


            try
            {
                // validate the number of allowed users here
                int totalUsers = IdentityStore.CountTotalUsers();
                string msg = "";
                int allowedUsers = 0;
                bool hasFeature = AppInfo.Get.LicenseHasValidIntegerFeature(out msg, "USER_COUNT", out allowedUsers);
                bool canAddNewUser = hasFeature && (totalUsers < allowedUsers);

                if (canAddNewUser)
                {
                    // Ensure user id and password are supplied
                    IdentityStore id = (IdentityStore) userInfo;
                    // Create the user based on the TYPE
                    CrudOperationResult<IdentityStore> crud = null;
                    if (userInfo.ObjType == AppConstants.SYS_USER_ACCOUNT)
                    {
                        // Ensure no Admin, BranchAdmin Role is included
                        // create the user
                        foreach (var r in roles)
                        {
                            if (r.Name == AppRoleName.SUPER_ADMIN_ROLE || r.Name == AppRoleName.USER_MANAGER)
                            {
                                res.Message =
                                    "You can't assign a User Manager role and 'Super Admin' Role to a User account type. Please select other role type.";
                                res.Success = false;
                                return res;

                            }

                        }
                        crud = UserIdentity.CreateNewUser(id.Key, id.Password, id.DisplayName, id.PictureUrl, id.ChannelId);
                        // check if we where successful

                    }
                    else if (userInfo.ObjType == AppConstants.SYS_ADMIN_ACCOUNT)
                    {
                        crud = SuperAdminIdentity.CreateNewAdmin(id.Key, id.Password, id.DisplayName,id.PictureUrl);

                    }
                    else if (userInfo.ObjType == AppConstants.SYS_USER_MANAGER_ACCOUNT)
                    {
                        foreach (var r in roles)
                        {
                            if (r.Name == AppRoleName.SUPER_ADMIN_ROLE)
                            {
                                res.Message =
                                    "You can't assign a 'Super Admin' Role to a 'Channel' account type. Please select other role type.";
                                res.Success = false;
                                return res;

                            }

                        }
//                        crud = ChannelAdminUserIdentity.CreateNewUser(id.Key, id.Password, id.DisplayName,id.ChannelId, id.PictureUrl);
                    }
                    else
                    {
                        res.Message =
                            $"Not recognized account type! Valid account type are : {AppConstants.SYS_ADMIN_ACCOUNT}, {AppConstants.SYS_CHANNEL_ACCOUNT}, and {AppConstants.SYS_USER_ACCOUNT} ";
                        ;
                        res.Success = false;
                        return res;
                    }
                    if (crud.IsSuccess)
                    {
                        // let's add the required role if we have any
                        if (userInfo.ObjType == AppConstants.SYS_USER_ACCOUNT)
                        {
                            foreach (var r in roles)
                            {
                                RoleManager.SetUserRole(id, (Role) r);

                            }
                        }
                        else if (userInfo.ObjType == AppConstants.SYS_USER_MANAGER_ACCOUNT)
                        {
                             foreach (var r in roles)
                            {
                                if (r.Name != AppRoleName.USER_MANAGER)
                                {
                                    RoleManager.SetUserRole(id, (Role) r);
                                }


                            }
                        }



                    }
                    res = ServerResponseModel.From(crud);

                    res.Data = (UserIdentityModel) id;
                }
                else
                {
                    res.Message = $"The number of Users allowed for {((AsomAppLicense)AppInfo.Get.GetReadOnlyAppLicense().Data).AppDefinition.AppName} is {allowedUsers}, which is exhausted. To add new user please Contact {AppInfo.Get.AppCompanyName} on any of this numbers {AppInfo.Get.AppCompanyPhone} Thank you.";
                    res.Success = false;

                }



                // let try creating the user here
                //  = id.Create();

            }
            catch (Exception err)
            {
                res.ServerException = err;

            }

            return res;
        }


        public static ServerResponseModel DeleteUserIdentity(UserIdentityModel userInfo)
        {
            ServerResponseModel  res  =  new ServerResponseModel();
            res.Message = "Could not Complete Your Request! Delete Failed";
            res.Success = false;
            res.IsAuthorize = true;
            res.Data = userInfo;


            //TODO :  Validate The Number of Users allowed for this user License


            try
            {
                // validate the number of allowed users here
                 string msg = "";
                 IdentityStore id = IdentityStore.GetUserIdentity(userInfo.UserId);

                if (id != null)
                {
                    if (!string.IsNullOrEmpty(id.ObjType) && id.ObjType != AppConstants.SYS_ADMIN_ACCOUNT)
                    {
                        // Cannot
                        CrudOperationResult<IdentityStore> s  = id.Drop();
                        res  = ServerResponseModel.From(s);
                        if (s.IsSuccess)
                        {
                             res.Data = (UserIdentityModel) s.Data;
                        }

                    }
                    else
                    {
                        res.Message = "You can't Delete a Super Admin Account!";
                    }

                }
                else
                {
                    res.Message = "The Current user Record was not found!";
                    res.Success = false;

                }





                // let try creating the user here
                //  = id.Create();

            }
            catch (Exception err)
            {
                res.ServerException = err;

            }

            return res;
        }

        public static ServerResponseModel BlockUserIdentity(string userId)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Could not Complete Your Request! Block Failed";
            res.Success = false;
            res.IsAuthorize = true;
            res.Data = null;
            try
            {
                IdentityStore id = new IdentityStore() {Key = userId};
                var crud = id.BlockUser();
                res = ServerResponseModel.From(crud);
                res.Data = null;
                if (crud.IsSuccess)
                {
                    res.Data = (UserIdentityModel)crud.Data;
                }


            }
            catch (Exception err)
            {
                res.ServerException = err;

            }

            return res;
        }
        public static ServerResponseModel UnBlockUserIdentity(string userId)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Could not Complete Your Request! UnBlock Failed";
            res.Success = false;
            res.IsAuthorize = true;
            res.Data = null;
            try
            {
                IdentityStore id = new IdentityStore(){Key = userId};
                var crud = id.UnBlockUser();
                res = ServerResponseModel.From(crud);
                res.Data = null;
                if (crud.IsSuccess)
                {
                    res.Data = (UserIdentityModel)crud.Data;
                }


            }
            catch (Exception err)
            {
                res.ServerException = err;

            }

            return res;
        }

        public static ServerResponseModel ChangeUserIdentityPassword(string userId, string oldPassword, string newPassword )
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Could not Complete Your Request! Change Password Failed";
            res.Success = false;
            res.IsAuthorize = true;
            res.Data = null;
            try
            {
                IdentityStore id = new IdentityStore() { Key = userId };
                var crud = id.ChangePassword(oldPassword, newPassword);
                res = ServerResponseModel.From(crud);
                res.Data = null;
                if (crud.IsSuccess)
                {
                    res.Data = (UserIdentityModel)crud.Data;
                }


            }
            catch (Exception err)
            {
                res.ServerException = err;

            }

            return res;
        }
      public static string GetForgetPasswordEmail(string newPassword, string userId)
      {

        CompanyInfoModel org = CompanyInfoModel.Get;

        string res = @"
                    <div style='width:85% ;background-color: #fff ;padding  : 30px ; margin:20px ;  border: 2px solid #4c505e; min-height: 400px;'>
  <div style='float: left; margin-right: 30px; width:130px;'>
    <img src='[logo]' alt='[company]' width='100px' />
  </div>
  <div style='float: left; text-align: center'>
    <h1>[company]</h1><br>
    <p ><span>Password Reset Was Successfull!</span></p>
  </div>

  <div style='clear:both; margin-top:  20px;padding:20px'>
    <h4>
      Hello! [userName], Your account password reset was Successful
      <br>
      <br>
      <h2 style='color:red'>Here is your password  : [newPassword]</h2>
       <br>
      <br>
      Login and change this password to a desired one and always keep your password secured and do not share your
      password with anyone!
      <br><br><br><br>


    </h4>
<br><br />
    <b>Best regards, Team [company]</b>

  </div>

</div>

";

        res = res.Replace("[userName]", userId);
        res = res.Replace("[company]", org.Name);
        res = res.Replace("[logo]", org.LogoUrl);
        res = res.Replace("[newPassword]", newPassword);




        return res;
      }
    public static ServerResponseModel ForgotPasswordProcess(string userId, string emailAddress)
      {
        ServerResponseModel res = new ServerResponseModel();
        res.Message = "Could not Complete Your Request at the moment!";
        res.Success = false;
        res.IsAuthorize = true;
        res.Data = null;
        try
        {
          emailAddress = emailAddress.Trim().ToLower();
          var userNameCrud = IdentityStore.GetUserName(userId.Trim());
          if (userNameCrud.IsSuccess)
          {
            var data = userNameCrud.Data;
            if (userId == data.UserId)
            {
              if (!data.HasEmail)
              {
                res.Message = "You do not have an email address for password Recovery!";
                res.Data = new { userId, emailAddress };
                return res;
              }
              if (emailAddress == data.Email.ToLower())
              {
                // Reset Password
                var crud = IdentityStore.ResetPassword(data.UserId);
                if (crud.IsSuccess)
                {
                  IEmailSettings email = OrgAppSetting.GetEmailSettings();

                  if (!string.IsNullOrEmpty(email.SmtpPassword) && !string.IsNullOrEmpty(email.SmtpUserId) &&
                      !string.IsNullOrEmpty(email.SmtpServerAddress) &&
                      !string.IsNullOrEmpty(email.SmtpPortNumber))
                  {
                    var nePwd = crud.Data;
                    string body = GetForgetPasswordEmail(nePwd.Password, userNameCrud.Data.DisplayName);
                    // res.Message = "Get Email Template for Password retrival called!";
                    MimeMessage msg  = new MimeMessage();
                    msg.From.Add( new MailboxAddress(email.SmtpUserId));
                    msg.To.Add( new MailboxAddress(emailAddress));
                    msg.Subject = "DO NOT REPLY, Recovery Password Process";
                    msg.Body =  new TextPart("html")
                    {
                      Text = body
                    };

//                    MailMessage mail = new MailMessage(email.SmtpUserId, emailAddress,
//                      "DO NOT REPLY, Recovery Password Process", body);
//                    mail.IsBodyHtml = true;
                    Thread t = new Thread(new ThreadStart((() =>
                    {
                      using (var client = new SmtpClient ()) {
                        client.AuthenticationMechanisms.Remove ("XOAUTH2");
                        //client.SslProtocols  = SslProtocols.Default;
                        // For demo-purposes, accept all SSL certificates (in case the server supports STARTTLS)
                        client.ServerCertificateValidationCallback = (s,c,h,e) => true;

                        client.Connect (email.SmtpServerAddress.Trim(), int.Parse(email.SmtpPortNumber.Trim())/*,Properties.Settings.Default.useHttps*/);

                        // Note: only needed if the SMTP server requires authentication
                        client.Authenticate (email.SmtpUserId.Trim(), email.SmtpPassword.Trim());

                        client.Send (msg);
                        client.Disconnect (true);
                      }
//                      SmtpClient smtp = new SmtpClient(email.SmtpServerAddress,
//                        int.Parse(email.SmtpPortNumber));
//                      smtp.Credentials = new NetworkCredential(email.SmtpUserId, email.SmtpPassword);
//                      smtp.Send(mail);


                    })));
                    t.Start();
                  }


                  res = ServerResponseModel.From(crud);
                  res.Message =
                    "Your password has been reset, Please check your email for your new password. If no Email is received within 5 mins, please resend Email";
                  res.Success = true;
                  res.Data = new {userId, emailAddress};

                }
                else
                {
                  res.Message = crud.Message;
                }
              }
              else
              {
                //Supply email hint
                res.Message = "Invalid Email supplied. Please enter the email address used during registration.";
                res.Success = false;
              }
            }



          }
          else
          {
            res.Message = "User Data not found";
          }
        }
        catch (Exception err)
        {
        res.Message = err.Message;
          res.Data = err.StackTrace;
          res.ServerException = err;

        }

        return res;
      }
    public static ServerResponseModel GetIdentity(string name, bool includePassword)
        {

            CrudOperationResult<IdentityStore> res  =  IdentityStore.GetIdentity(name);
            ServerResponseModel dd  =  ServerResponseModel.From(res);

            if (res.IsSuccess)
            {
                UserIdentityModel im = res.Data;
                if (!includePassword)
                {
                    im.Password = "***********";
                }


                dd.Data = im;
            }


            return dd;

        }

        public static bool IsAuthenticated
        {
            get { return HttpContext.Current.User.Identity.IsAuthenticated; }
        }
        public static bool HasAuthority(string permission)
        {
            bool res = false;// throw new NotImplementedException();
            if (IsAuthenticated)
            {
                 res =  RoleManager.CheckForPermissionOnUser(IdentitySession.GetUser(), permission, true);
            }
            return res;
        }
        public static bool HasAuthority(string[] permissions)
        {
            bool res = false;// throw new NotImplementedException();

            foreach (var perm in permissions)
            {
                res = HasAuthority(perm);
                if (res == false)
                {
                    break;
                }
            }
            //res =  RoleManager.CheckForPermissionOnUser(IdentitySession.GetUser(), permission, true);
            return res;
        }



        public object Id
        {
            get { return UserId; }
            set { UserId = value.ToString(); }
        }

        public IEnumerable<Role> Roles { get; set; }
        [JsonIgnore]
        bool IUserContext.IsAuthenticated { get; set; }

        public bool IsInRole(string role)
        {
            return true;
        }

    }

    public class IdentityPreferenceModel
    {
        public string Id { get; set; }

        public string PrefKey { get; set; }
        public string PrefValue { get; set; }
        public string DataType { get; set; }

        public static implicit operator IdentityPreferenceModel(IdentityPreference o)
        {
            IdentityPreferenceModel   res  =  new IdentityPreferenceModel();
            res.Id = o.Key;
            res.DataType = o.DataType;
            res.PrefKey = o.PrefKey;
            res.PrefValue = o.PrefValue;
            return res;
        }
        public static explicit operator IdentityPreference(IdentityPreferenceModel o)
        {
            IdentityPreference   res  =  new IdentityPreference();
            res.Id = o.Id;
            res.DataType = o.DataType;
            res.PrefKey = o.PrefKey;
            res.PrefValue = o.PrefValue;
            return res;
        }

        public static IEnumerable<IdentityPreferenceModel> fromEnitity(IEnumerable<IdentityPreference> preferences)
        {
            return preferences.Select(x => (IdentityPreferenceModel) x);
        }
    }


  public class UserIdentityNameModel
  {
    public string Id { get; set; }
    public string DisplayName { get; set; }
    public string PictureUrl { get; set; }


    public static implicit operator UserIdentityNameModel(IdentityStoreName e)
    {
      UserIdentityNameModel res = new UserIdentityNameModel();
      res.DisplayName = e.DisplayName;
      res.PictureUrl = e.PictureUrl;
      res.Id = e.UserId;
      return res;
    }
  }

}
