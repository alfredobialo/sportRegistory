using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model.authentication
{
    public class UserIdentity : IdentityStore
    {
        public static CrudOperationResult<IdentityStore> CreateNewUser(string userId, string password,
            string displayName, string channelId)
        {
            IdentityStore id = new IdentityStore();
            //TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.IsBlocked = false;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_USER_ACCOUNT;
            id.ChannelId = string.IsNullOrEmpty(channelId) ? OrganizationInfo.ORG_CODE : channelId.ToUpper();
            id.Gender = AppConstants.GENDER_MALE;
            return id.Create();
        }

        public static CrudOperationResult<IdentityStore> CreateNewUser(string userId, string password,
            string displayName, string pictureUrl, string channelId)
        {
            IdentityStore id = new IdentityStore();
            //TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.IsBlocked = false;
            id.PictureUrl = pictureUrl;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_USER_ACCOUNT;
            id.ChannelId = string.IsNullOrEmpty(channelId) ? OrganizationInfo.ORG_CODE : channelId.ToUpper();
            id.Gender = AppConstants.GENDER_MALE;
            return id.Create();
        }

        public static IdentityStore CreateUserInstance(string userId, string password, string displayName,
            string channelId = OrganizationInfo.ORG_CODE)
        {
            IdentityStore id = new IdentityStore();
            //TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.IsBlocked = false;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_USER_ACCOUNT;
            id.ChannelId = string.IsNullOrEmpty(channelId) ? OrganizationInfo.ORG_CODE : channelId.ToUpper();
            id.Gender = AppConstants.GENDER_MALE;
            return id;
        }
        public static IdentityStore RegisterNewUserInstance(string userId, string password, string displayName,
            string channelId = OrganizationInfo.ORG_CODE)
        {
            IdentityStore id = new IdentityStore();
            //TODO : id.Roles = this.Roles; // assign admin Role, this might change
            id.Key = userId;
            id.Password = password;
            id.DisplayName = displayName;
            id.IsBlocked = false;
            id.IsOn = true;
            id.ObjType = AppConstants.SYS_USER_ACCOUNT;
            id.ChannelId = string.IsNullOrEmpty(channelId) ? OrganizationInfo.ORG_CODE : channelId.ToUpper();
            id.Gender = AppConstants.GENDER_MALE;

            return id;
        }
    }
}
