using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.securables;

namespace asom.apps.inOut.core.model.authentication
{
    public class SuperAdminIdentity  : IdentityStore
    {
        public static bool IsAnySuperAdminAccountStored
        {
            get { return ((IdentityStoreRepo) new IdentityStore().DataSource).CountSuperAdminAccount() > 0; }
        }

        public SuperAdminIdentity()
        {
            AddAdminRoles();
        }

        public static CrudOperationResult<IdentityStore> CreateNewAdmin(string userId, string password, string displayName)
        {
            IdentityStore id  =  new IdentityStore();
            // TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.IsBlocked = false;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_ADMIN_ACCOUNT;
            id.ChannelId = OrganizationInfo.ORG_CODE;
            var crud  = id.Create();
            if (crud.IsSuccess)
            {
                // add user permission automatically
                if (RoleManager.RoleExistInStore(AppRoleName.SUPER_ADMIN_ROLE))
                {
                    
                    RoleManager.SetUserRole(id, AppRoleName.SuperAdminRole);
                }
            }
            return crud;

        }
        public static CrudOperationResult<IdentityStore> CreateNewAdmin(string userId, string password, string displayName, string pictureUrl)
        {
            IdentityStore id = new IdentityStore();
            // TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.PictureUrl = pictureUrl;
            id.IsBlocked = false;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_ADMIN_ACCOUNT;
            id.ChannelId = OrganizationInfo.ORG_CODE;
            var crud = id.Create();
            if (crud.IsSuccess)
            {
                // add user permission automatically
                if (RoleManager.RoleExistInStore(AppRoleName.SUPER_ADMIN_ROLE))
                {

                    RoleManager.SetUserRole(id, AppRoleName.SuperAdminRole);
                }
            }
            return crud;

        }
        private void AddAdminRoles()
        {
            
        }
    }
}
