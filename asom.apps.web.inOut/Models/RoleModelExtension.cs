using System.Collections.Generic;
using itrex.businessObjects.model.core.OpenModel;

namespace asom.apps.web.inOut.Models
{
    public class RoleModelExtension  : RoleModel
    {
        /// <summary>
        /// Use this property to get the exact users in each role 
        /// because deleting a user account will not affect the role api internally
        /// </summary>
        /// <param name="roleInfo"></param>
        /// <returns></returns>
        public  IEnumerable<UserInfoModel> UserDetails 
        {
            get
            {
                IEnumerable<UserInfoModel> users = new List<UserInfoModel>();
                // get each user collection and map to this object
                foreach (var user in Users)
                {
                    var crud = UserIdentityModel.GetIdentity(user.Id.ToString(), false);
                    if (crud.Success)
                    {
                        // User Record is found
                        UserInfoModel uu = crud.Data;
                        ((List<UserInfoModel>) users).Add(uu);
                    }

                }
                return users;
            }

        }

        public static RoleModelExtension From(RoleModel r)
        {
            RoleModelExtension res  =  new RoleModelExtension();
            res.Users = r.Users;
            res.Id = r.Id;
            res.Description = r.Description;
            res.ExpirationDate = r.ExpirationDate;
            res.GroupName = r.GroupName;
            res.IsActive = r.IsActive;
            res.IsAdmin = r.IsAdmin;
            res.IsSystemDefined = r.IsSystemDefined;
            res.IsExpirable = r.IsExpirable;
            res.Permissions = r.Permissions;
            res.IsExpired = r.IsExpired;
            res.Name = r.Name;
            
            return res;
        }
    }
    public class UserInfoModel
    {
        public string Id { get; set; }
        public string DisplayName { get; set; }
        public string ChannelId { get; set; }
        public string PictureUrl { get; set; }

        public static implicit operator UserInfoModel(UserIdentityModel user)
        {
            UserInfoModel res = new UserInfoModel();
            res.Id = user.UserId;
            res.ChannelId = user.ChannelId;
            res.DisplayName = user.DisplayName;
            res.PictureUrl = user.PictureUrl;
            return res;
        }

    }
}