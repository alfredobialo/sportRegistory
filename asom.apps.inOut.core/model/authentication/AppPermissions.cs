using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core.securables;

namespace asom.apps.inOut.core.model.authentication
{
    public static class AppRoleName
    {
        public const string SUPER_ADMIN_ROLE = "SUPER_ADMIN";
       
        public const string PIN_MANAGER = "PIN_MANAGER";
        public const string BASIC_USER = "BASIC_USER";
        public const string ADVANCE_USER = "ADVANCE_USER";
        public const string STANDARD_USER = "STANDARD_USER";
        public const string PAIR_MANAGER = "PAIR_MANAGER";
        public const string SECURITY_MANAGER = "SECURITY_MANAGER";
        public const string USER_MANAGER = "USER_MANAGER";
        

        public static Role SuperAdminRole
        {
            get
            {
                Role r = RoleManager.CreateRole(SUPER_ADMIN_ROLE, AppPermissions.SuperAdminPermission);
                r.Description = "Has Full access to all application Components.";
                r.IsAdmin = true;
                r.IsSystemDefined = true;
                r.IsExpirable = false;
                r.IsActive = true;
                r.GroupName = OrganizationInfo.ORG_CODE;
                return r;
            }


        }

       public static Role BasicUserRole
        {
            get
            {
                Role r = RoleManager.CreateRole(BASIC_USER, AppPermissions.BasicUserPermission);
                r.Description = "Basic User Access to systems functions";
                r.IsAdmin = true;
                r.IsSystemDefined = true;
                r.IsExpirable = false;
                r.IsActive = true;
                r.GroupName = OrganizationInfo.ORG_CODE;
                return r;
            }


        }
        public static Role StandardUserRole 
        {
            get
            {
                Role r = RoleManager.CreateRole(STANDARD_USER, AppPermissions.StandardUserPermission);
                r.Description = "Standard User Access to systems functions. better access than the basic access";
                r.IsAdmin = true;
                r.IsSystemDefined = true;
                r.IsExpirable = false;
                r.IsActive = true;
                r.GroupName = OrganizationInfo.ORG_CODE;
                return r;
            }


        }
        public static Role AdvanceUserRole 
        {
            get
            {
                Role r = RoleManager.CreateRole(ADVANCE_USER, AppPermissions.AdvanceUserPermission);
                r.Description = "Advance User Access to systems functions. better access than the Standard access";
                r.IsAdmin = true;
                r.IsSystemDefined = true;
                r.IsExpirable = false;
                r.IsActive = true;
                r.GroupName = OrganizationInfo.ORG_CODE;
                return r;
            }


        }
       public static Role UserManagerRole 
        {
            get
            {
                Role r = RoleManager.CreateRole(USER_MANAGER, AppPermissions.UserMangerPermission);
                r.Description = "has Advance access to all Users account, can edit user account profile.";
                r.IsAdmin = true;
                r.IsSystemDefined = true;
                r.IsExpirable = false;
                r.IsActive = true;
                r.GroupName = OrganizationInfo.ORG_CODE;
                return r;
            }


        }
        public static bool InstallSystemRoles(bool updateRoleIfFound)
        {
            bool res = false;
            try
            {
                // if role Exist, Reset the Permission to prevent data lost
                var exist = RoleManager.RoleExistInStore(SUPER_ADMIN_ROLE);
                if (!exist)
                {
                    var role  = RoleManager.CreateRole(SuperAdminRole, AppPermissions.SuperAdminPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        SuperAdminRole.Save(true);
                    } 
                    SuperAdminRole.ResetPermissionWith(AppPermissions.SuperAdminPermission);
                   
                }

                //////////////////////////////////////////////////////////////////////////

                exist = RoleManager.RoleExistInStore(USER_MANAGER);
                if (!exist)
                {
                    var role = RoleManager.CreateRole(USER_MANAGER, AppPermissions.UserMangerPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        UserManagerRole.Save(true);
                    }
                    UserManagerRole.ResetPermissionWith(AppPermissions.UserMangerPermission);

                }

                //////////////////////////////////////////////////////////////////////////

                exist = RoleManager.RoleExistInStore(BASIC_USER);
                if (!exist)
                {
                    var role = RoleManager.CreateRole(BASIC_USER, AppPermissions.BasicUserPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        BasicUserRole.Save(true);
                    }
                    BasicUserRole.ResetPermissionWith(AppPermissions.BasicUserPermission);

                }

                //////////////////////////////////////////////////////////////////////////

                exist = RoleManager.RoleExistInStore(STANDARD_USER);
                if (!exist)
                {
                    var role = RoleManager.CreateRole(STANDARD_USER, AppPermissions.StandardUserPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        StandardUserRole.Save(true);
                    }
                    StandardUserRole.ResetPermissionWith(AppPermissions.StandardUserPermission);

                }

                //////////////////////////////////////////////////////////////////////////

                exist = RoleManager.RoleExistInStore(ADVANCE_USER);
                if (!exist)
                {
                    var role = RoleManager.CreateRole(ADVANCE_USER, AppPermissions.AdvanceUserPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        AdvanceUserRole.Save(true);
                    }
                    AdvanceUserRole.ResetPermissionWith(AppPermissions.AdvanceUserPermission);

                }

                //////////////////////////////////////////////////////////////////////////

                exist = RoleManager.RoleExistInStore(USER_MANAGER);
                if (!exist)
                {
                    var role = RoleManager.CreateRole(USER_MANAGER, AppPermissions.UserMangerPermission);
                    role.Save();

                }
                else
                {
                    if (updateRoleIfFound)
                    {
                        UserManagerRole.Save(true);
                    }
                    UserManagerRole.ResetPermissionWith(AppPermissions.UserMangerPermission);

                }

                res = true;
            }
            catch 
            {
                
                
            }
            return res;
        }
        public static bool InstallSystemRoles()
        {
            
            return InstallSystemRoles(false);
        }
    }
    public class AppPermissions
    {
        public const string MANAGE_MESSAGING_SERVICES  = "MANAGE_MESSAGING_SERVICES";
        public const string VIEW_MESSAGING_THREAD  = "VIEW_MESSAGING_THREAD";
        public const string DELETE_MESSAGING_THREAD  = "DELETE_MESSAGING_THREAD";
        public const string WRITE_MESSAGE_COMMENT  = "WRITE_MESSAGE_COMMENT";
        public const string EDIT_MESSAGE_COMMENT  = "EDIT_MESSAGE_COMMENT";

        public const string CORE_APP_FUNCTIONS_MANAGER  = "CORE_APP_FUNCTIONS_MANAGER";
        public const string LICENSE_EXTEND_APPLICATION_FEATURES   = "LICENSE_EXTEND_APPLICATION_FEATURES";
        public const string LICENSE_ATTACH_APPLICATION_LICENSE = "LICENSE_ATTACH_APPLICATION_LICENSE";
        public const string APP_BACKUP_UPDATE_APPLICATION_FUNCTIONS  = "APP_BACKUP_UPDATE_APPLICATION_FUNCTIONS";
        public const string MANAGE_APP_SETTINGS  = "MANAGE_APP_SETTINGS";


        // TRANSACTIONS, Sales and Purchase Orders
        
        
               public const string GENERATE_PIN = "GENERATE_PIN";
                public const string AUTOMATE_ENGINE = "AUTOMATE_ENGINE";
                public const string PAIR_USERS = "PAIR_USERS";
                public const string MANAGE_USERS = "MANAGE_USER";
                public const string BASIC_USER_BONUS = "BASIC_USER_BONUS";
                public const string BASIC_USER_INTEREST = "BASIC_USER_INTEREST";
                public const string STANDARD_USER_BONUS =    "STANDARD_USER_BONUS";
                public const string STANDARD_USER_INTEREST = "STANDARD_USER_INTEREST";
                public const string ADVANCE_USER_BONUS =    "ADVANCE_USER_BONUS";
                public const string ADVANCE_USER_INTEREST = "ADVANCE_USER_INTEREST";

        public const string AUTHORIZATION_CREATE_USERS = "AUTHORIZATION_CREATE_USERS";
        public const string AUTHORIZATION_BLOCK_USERS_ACCOUNT = "AUTHORIZATION_BLOCK_USERS_ACCOUNT";
        public const string AUTHORIZATION_DROP_USERS_ACCOUNT = "AUTHORIZATION_DROP_USERS_ACCOUNT";
        public const string AUTHORIZATION_EDIT_OWN_ACCOUNT = "AUTHORIZATION_EDIT_OWN_ACCOUNT";
        public const string AUTHORIZATION_EDIT_USERS_ACCOUNT = "AUTHORIZATION_EDIT_USERS_ACCOUNT";
        public const string AUTHORIZATION_ADD_USERS_ROLE = "AUTHORIZATION_ADD_USERS_ROLE";
        public const string AUTHORIZATION_ADD_USER_ADMIN_ROLE = "AUTHORIZATION_ADD_USER_ADMIN_ROLE";
        public const string AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE = "AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE";
        public const string AUTHORIZATION_CREATE_CUSTOM_ROLES = "AUTHORIZATION_CREATE_CUSTOM_ROLES";

        public static  RolePermissionList SuperAdminPermission
        {
            get
            {

                var res  = new RolePermissionList();
                res.Add((RolePermission)CORE_APP_FUNCTIONS_MANAGER);
                res.Add((RolePermission)GENERATE_PIN);
                res.Add((RolePermission)MANAGE_APP_SETTINGS);
                res.Add((RolePermission)APP_BACKUP_UPDATE_APPLICATION_FUNCTIONS);
                res.Add((RolePermission)LICENSE_ATTACH_APPLICATION_LICENSE);
                res.Add((RolePermission)LICENSE_EXTEND_APPLICATION_FEATURES);
                



                //AUTHORIZATION
                res.Add((RolePermission)AUTHORIZATION_EDIT_USERS_ACCOUNT);
                res.Add((RolePermission)AUTHORIZATION_CREATE_CUSTOM_ROLES);
                res.Add((RolePermission)AUTHORIZATION_CREATE_USERS);
                res.Add((RolePermission)AUTHORIZATION_DROP_USERS_ACCOUNT);
                res.Add((RolePermission)AUTHORIZATION_EDIT_OWN_ACCOUNT);
                res.Add((RolePermission)AUTHORIZATION_ADD_USERS_ROLE);
                res.Add((RolePermission)AUTHORIZATION_ADD_USER_ADMIN_ROLE);
                res.Add((RolePermission)AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE);
                res.Add((RolePermission)AUTHORIZATION_BLOCK_USERS_ACCOUNT);

                res.Add((RolePermission)VIEW_MESSAGING_THREAD);
                res.Add((RolePermission)DELETE_MESSAGING_THREAD);
                res.Add((RolePermission)WRITE_MESSAGE_COMMENT);
                res.Add((RolePermission)EDIT_MESSAGE_COMMENT);
                res.Add((RolePermission)MANAGE_MESSAGING_SERVICES);
                // OTHERS

                res.Add((RolePermission)MANAGE_USERS);
                res.Add((RolePermission)BASIC_USER_BONUS);
                res.Add((RolePermission)BASIC_USER_INTEREST);
                res.Add((RolePermission)STANDARD_USER_BONUS);
                res.Add((RolePermission)STANDARD_USER_INTEREST);
                res.Add((RolePermission)ADVANCE_USER_BONUS);
                res.Add((RolePermission)ADVANCE_USER_INTEREST);
                res.Add((RolePermission)AUTOMATE_ENGINE);
                res.Add((RolePermission)PAIR_USERS);
                return res;
            }

        }
        public static  RolePermissionList UserMangerPermission
        {
            get
            {

                var res  = new RolePermissionList();

                //AUTHORIZATION
                res.Add((RolePermission)AUTHORIZATION_EDIT_USERS_ACCOUNT);
                res.Add((RolePermission)AUTHORIZATION_CREATE_USERS);
                res.Add((RolePermission)AUTHORIZATION_EDIT_OWN_ACCOUNT);
                res.Add((RolePermission)AUTHORIZATION_ADD_USERS_ROLE);
                res.Add((RolePermission)AUTHORIZATION_BLOCK_USERS_ACCOUNT);


                // OTHERS

                res.Add((RolePermission)MANAGE_USERS);
    
               
                return res;
            }

        }
        public static  RolePermissionList BasicUserPermission
        {
            get
            {

                var res  = new RolePermissionList();

               //AUTHORIZATION
              
                res.Add((RolePermission)AUTHORIZATION_EDIT_OWN_ACCOUNT);
               


                // OTHERS

               
                res.Add((RolePermission)BASIC_USER_BONUS);
                res.Add((RolePermission)BASIC_USER_INTEREST);
                
                return res;
            }

        }
        public static  RolePermissionList StandardUserPermission
        {
            get
            {

                var res  = new RolePermissionList();

               //AUTHORIZATION
              
                res.Add((RolePermission)AUTHORIZATION_EDIT_OWN_ACCOUNT);



                // OTHERS

                res.Add((RolePermission)BASIC_USER_BONUS);
                res.Add((RolePermission)BASIC_USER_INTEREST);
                res.Add((RolePermission)STANDARD_USER_INTEREST);
                res.Add((RolePermission)STANDARD_USER_BONUS);
                
                return res;
            }

        }
        public static  RolePermissionList AdvanceUserPermission
        {
            get
            {

                var res  = new RolePermissionList();

               //AUTHORIZATION
              
                res.Add((RolePermission)AUTHORIZATION_EDIT_OWN_ACCOUNT);



                // OTHERS

                res.Add((RolePermission)BASIC_USER_BONUS);
                res.Add((RolePermission)BASIC_USER_INTEREST);
                res.Add((RolePermission)STANDARD_USER_INTEREST);
                res.Add((RolePermission)STANDARD_USER_BONUS);
                res.Add((RolePermission)ADVANCE_USER_INTEREST);
                res.Add((RolePermission)ADVANCE_USER_BONUS);
                
                return res;
            }

        }
    }


}
