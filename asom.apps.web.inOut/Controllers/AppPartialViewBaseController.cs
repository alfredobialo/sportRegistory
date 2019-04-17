using System.Web.Mvc;
using asom.apps.inOut.core.model.authentication;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models.Navigation;

//http://localhost:38569/Sys#/settings/other-settings
namespace asom.apps.web.inOut.Controllers
{

    [OutputCache(Duration = 2, VaryByParam = "id")]
    public class AppPartialViewBaseController : BaseController
    {
        private const string APP_CONFIG  ="app_config";
        private const string EDIT_COMPANY  ="edit_company";
        private const string MANAGE_USERS  ="manage-users";
        private const string USER_MANAGEMENT_CONSOLE  = "user-management-console";
        private const string USER_ISSUE_TRACKER  ="user-issue";
        private const string USER_CONSOLE_DASHBOARD  ="user-dashboard";
        private const string MANAGE_PERMISSION  ="manage-permissions";
        private const string APP_DASHBOARD = "app-dashboard";
        private const string MY_PROFILE = "my-profile";
        // For Sales Menu
        private const string Transaction_DASHBORAD  ="transactions-dashboard";
        private const string ALERT_PARTIAL  ="alerts-partial";
        private const string GH_TICKET  = "gh-ticket-partial";
        private const string PH_TICKET = "ph-ticket-partial";
        private const string ALL_GH_TCKETS  ="all-gh-ticket-partial";
        private const string ALL_PH_TCKETS  ="all-ph-ticket-partial";
        private const string BANK_SETUP  ="bank-setup-partial";
        private const string REGISTRATION_SETUP  ="registration-partial";
        private const string TICKET_ISSUE = "ticket-issue";
        private const string NotificationDashboard = "sys-notify";
        private const string Messages = "message";

        // Accounting Partial View Constant

        // License Partial
        private const string LICENSE_SETUP = "license-setup";

        private const string    LOGIN_VIEW = "login_view";
        public ActionResult FindPartial(string id)
        {
            //            if (!User.Identity.IsAuthenticated)
            //            {
            //                return AuthenticationRequiredView;
            //            }
            // Get Systems Roles that could perform administrative function
            bool hasAdminAccess = new IdentityStore().HasAuthority(
                new string[] { AppPermissions.CORE_APP_FUNCTIONS_MANAGER, AppPermissions.MANAGE_APP_SETTINGS }
            );
            bool manageUsers  = new IdentityStore().HasAuthority(AppPermissions.MANAGE_USERS);
            if (!string.IsNullOrEmpty(id))
            {
                id = id.ToLower();
                if (id == APP_CONFIG)
                {
                    if (!hasAdminAccess)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/settings/_appconfig");
                }
                else if(id == MANAGE_USERS)
                {
                    return PartialView("ui/_partials/settings/_create_users");
                }
                else if(id == MANAGE_PERMISSION)
                {
                    // check if the User is allowed to make the request
                    bool access  =  new IdentityStore().HasAuthority(AppPermissions.AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE);
                    if (!access)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/settings/_manage_permission");
                }
                else if(id == EDIT_COMPANY)
                {

                    if (!hasAdminAccess)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/settings/_edit_company");
                } 
                else if(id == REGISTRATION_SETUP)
                {
                 
                    if (!hasAdminAccess)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_register");
                }
                else if(id == APP_DASHBOARD)
                {
                    return PartialView("ui/_partials/dashboard/_dashboard");
                }
                // Sales Menu


                else if
                    (id == MY_PROFILE)
                {
                    return PartialView("ui/_partials/settings/myprofile");
                }
                else if(id == LOGIN_VIEW)
                {
                    return AuthenticationRequiredView;
                }
                else if(id == LICENSE_SETUP)
                {
                    return PartialView("ui/_partials/license/_add_license");
                }
                else if (id == Transaction_DASHBORAD)
                {
                    return PartialView("ui/_partials/transaction/_transaction_dashboard");
                }
                else if (id == GH_TICKET)
                {
                    return PartialView("ui/_partials/transaction/_gh");
                }
                else if (id == PH_TICKET)
                {
                    return PartialView("ui/_partials/transaction/_ph");
                }
                else if (id == ALL_GH_TCKETS)
                {
                    if (!hasAdminAccess)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/transaction/user_specific/_admin_gh");
                }
                else if (id == ALL_PH_TCKETS)
                {
                    if (!hasAdminAccess)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/transaction/user_specific/_admin_ph");
                }
                else if (id == BANK_SETUP)
                {
                    return PartialView("ui/_partials/bank/_bank_dashboard");
                }
                else if (id == USER_MANAGEMENT_CONSOLE)
                {

                    if (!manageUsers)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/settings/_user_management_console");
                }
                else if (id == USER_ISSUE_TRACKER)
                {

                    if (!manageUsers)
                    {
                        return AccessDeniedView;
                    }
                    return PartialView("ui/_partials/settings/_user_issue_console");
                }
                else if (id == USER_CONSOLE_DASHBOARD)
                {

                    if (!manageUsers)
                    {
                        return AccessDeniedView;
                    }
                   
                    return PartialView("ui/_partials/settings/_user_console_dashboard");
                }
                
        
                else if (id == NotificationDashboard)
                {
                    return PartialView("ui/_partials/alert/sys_notifictaion");
                }
                else if (id == Messages)
                {
                    return PartialView("ui/_partials/alert/sys_message");
                }
            }
            return AccessDeniedView;
        }
    }
}