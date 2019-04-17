using System;
using System.Security.Principal;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model.authentication
{
    public delegate void OnAuthenticateHandler(object sender, AuthenticateEventArg e);

    public class AuthenticateEventArg : EventArgs
    {
        public IdentityStore CurrentUser { get; internal set; }
        public bool IsSuccess { get; set; }

        public AuthenticateEventArg(IdentityStore identity)
        {
            CurrentUser = identity;
        }

    }

    public class Authenticator
    {
        public  static event OnAuthenticateHandler OnAuthenticate = null;
        public static  bool Authenticate(string userId, string password, out IdentityStore credential)
        {
            userId = userId.Trim();

//            //string[] name  = new string[] { "Alfred Obialo", "James Uche", "Maryann Obialo", "Jude Okechukwu","Emmanuella Okkoi"};
//            int randSeed  =  new Random().Next(0, name.Length-1);
            credential = null;
            bool res = false;
            AuthenticateEventArg e =  new AuthenticateEventArg(null);
            var id = IdentityStore.GetIdentity(userId);
            if (id.IsSuccess  && id.Data.Key == userId && id.Data.Password == password && id.Data.IsBlocked == false && id.Data.IsOn == true)
            {
                res = true;
                credential = id.Data;
             
               
                    GenericIdentity iden = new GenericIdentity(userId, "FORMS");
                    GenericPrincipal p = new GenericPrincipal(iden, null);
                    AppConfig.GetInstance()
                        .SetCurrentUserFromThread(p);
             
                
                e.CurrentUser =(credential);
                e.IsSuccess = (true);
                
            }
            OnAuth(e);
            return res;
        }

        public static void SignOut()
        {
            AppConfig.GetInstance().CurrentUser = null;
        }
        protected  static void OnAuth(AuthenticateEventArg e)
        {
            if (OnAuthenticate != null)
            {
                OnAuthenticate(new Authenticator(), e);

            }


        } 
        public static  bool Authenticate(string userId, string password)
        {
            IdentityStore userInfo;
            return Authenticate(userId , password, out userInfo);
        }
        public static bool BlockUser(string userId)
        {
            // Get User from Db
            // block User
            // Update User
            return true;
        }
    }
    
}
