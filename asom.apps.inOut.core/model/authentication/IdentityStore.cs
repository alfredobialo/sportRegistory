using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using asom.apps.inOut.core.dal.sqlserver;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.pager;
using itrex.businessObjects.model.core.securables;
using itrex.Security.Cryptography;


namespace asom.apps.inOut.core.model.authentication
{

    public class IdentityPreference : DefaultPersistable<IdentityPreference>
    {
        public string IdentityId { get; internal set; }

        public string PrefKey { get; set; }
        public string PrefValue { get; set; }
        public string DataType { get; set; }
        public override DefRepository<IdentityPreference> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<IdentityPreference>.DataSource ?? new IdentityPreferenceRepo();
        }



        bool Exist(IUserContext user, IdentityPreference preference)
        {
            bool res = false;
            if (DataSource is IdentityPreferenceRepo)
            {
                IdentityPreferenceRepo repo = DataSource as IdentityPreferenceRepo;

                res = repo.PreferenceExistForUser(user, preference);
            }
            return res;
        }
        bool Exist(string user, string preference)
        {
            bool res = false;
            if (DataSource is IdentityPreferenceRepo)
            {
                IdentityPreferenceRepo repo = DataSource as IdentityPreferenceRepo;

                res = repo.PreferenceExistForUser(user, preference);
            }
            return res;
        }

        internal static IEnumerable<IdentityPreference> GetForUser(IUserContext user)
        {
            return new IdentityPreference().Find(new IdentityStoreCriteria() { Id = user.Id.ToString() });
        }

        public static void CreateDefaultPreference(IUserContext user, IEnumerable<IdentityPreference> preferences)
        {
            foreach (var p in preferences)
            {
                p.IdentityId = user.Id.ToString();
                if (!CheckIfPreferenceExist(user, p))
                    // Create preference
                    p.Create();
            }
        }

        public void Update()
        {
            if (Exist())
            {
                SaveSelf(this, true);
            }
        }

        private bool Exist()
        {
            return IsFound(this);
        }

        private void Create()
        {
            SaveOrIgnoreIfExist(this);
        }

        public static bool CheckIfPreferenceExist(IUserContext user, IdentityPreference preference)
        {
            return new IdentityPreference().Exist(user, preference);
        }
        public static bool CheckIfPreferenceExist(string user, string preference)
        {
            return new IdentityPreference().Exist(user, preference);
        }
    }

    public class IdentityPreferenceRepo : SqlServerDal<IdentityPreference>
    {
        protected internal IdentityPreferenceRepo()
        {

        }

        public override void Save(IdentityPreference obj)
        {
            identity_store_preference e = toEnitity(obj);
            db.identity_store_preference.Add(e);
            Save();
        }

        private identity_store_preference toEnitity(IdentityPreference o)
        {
            return toEnitity(new identity_store_preference(), o);
        }

        private identity_store_preference toEnitity(identity_store_preference e, IdentityPreference o)
        {
            e.id = o.Key;
            e.data_type = o.DataType;
            e.pref_key = o.PrefKey;
            e.pref_value = o.PrefValue;
            e.user_id = o.IdentityId;
            return e;
        }

        // check if a preference exist by a user
        protected internal virtual bool PreferenceExistForUser(IUserContext user, IdentityPreference preference)
        {
            return PreferenceExistForUser(user.Id.ToString(), preference.PrefKey);
        }
        protected internal virtual bool PreferenceExistForUser(string userId, string preferenceKey)
        {
            if (userId == null || preferenceKey == null)
            {
                return false;
            }
            bool res = db.identity_store_preference
                .Any(x => x.user_id == userId && x.pref_key == preferenceKey);

            return res;
        }
        public override IEnumerable<IdentityPreference> Get(Criteria criteria)
        {
            List<IdentityPreference> lst = new List<IdentityPreference>();
            if (criteria != null && criteria is IdentityStoreCriteria)
            {
                IdentityStoreCriteria cri = criteria as IdentityStoreCriteria;
                // get preference by user identity
                var data = db.identity_store_preference
                    .Where(x => x.user_id == cri.Id);
                foreach (var p in data)
                {
                    lst.Add(fromEnitity(p));
                }
            }
            return lst;
        }

        public override void Update(IdentityPreference obj)
        {
            var data = db.identity_store_preference.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                //toEnitity(data, obj);
                data.pref_value = obj.PrefValue;
                Save();
            }


        }

        public override void Delete(IdentityPreference obj)
        {
            var data = db.identity_store_preference.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                db.identity_store_preference.Remove(data);
                Save();
            }

        }

        public override IdentityPreference Get(object id)
        {
            IdentityPreference res = new IdentityPreference() { Id = id };
            var data = db.identity_store_preference.FirstOrDefault(x => x.id == res.Key);
            if (data != null)
            {
                res = fromEnitity(data);

            }
            return base.Get(id);
        }

        private IdentityPreference fromEnitity(identity_store_preference e)
        {
            IdentityPreference res = new IdentityPreference();
            res.IdentityId = e.user_id;
            res.Key = e.id;
            res.DataType = e.data_type;
            res.PrefKey = e.pref_key;
            res.PrefValue = e.pref_value;

            return res;

        }

        public override bool IsFound(IdentityPreference obj)
        {
            bool res = false;
            if (obj != null && !string.IsNullOrEmpty(obj.Key))
            {
                res = db.identity_store_preference.Any(x => x.id == obj.Key);
            }

            return res;
        }
    }

    public class IdentityStoreCriteria : ObjSearchCriteria
    {
        public bool UpdateProfilePicture { get; set; }
        public bool UpdateBlockedStatus { get; set; }
        public bool UpdatePassword { get; set; }
        public bool UpdateDisplayName { get; set; }
        public bool IncludeAdmin { get; set; } = true;
        public bool LoadOnlyAdmin { get; set; } = false;
        public String ObjectType { get; set; }
        public String ChannelId { get; set; }
        public String Gender { get; set; }
        public bool ActiveState { get; set; }
        public bool BlockedStatus { get; set; }
        public bool GetByObjectType { get; set; }
        public bool GetByIsActive { get; set; }
        public bool GetByIsBlocked { get; set; }
        public bool GetByChannel { get; set; }
        public bool GetByGender { get; set; }
        public bool GetByDateCreatedRange { get; set; }
        public bool ShowAllRecord { get; set; }
        public bool IncludePreference { get; set; }
      public bool UpdateEmail { get; set; }
    }


    public class IdentityStore : DefaultPersistable<IdentityStore>, IUserContext
    {
        private static string encryptionKey = "asom_identity_store_api";
        internal static string EncryptPassword(string password)
        {
            string res = password;
            try
            {
                string pwd = CryptoSecure.EncryptString(encryptionKey, password, DisplayFormat.Base64String);
                res = pwd;
            }
            catch (Exception err)
            {
                // Throw Catch Excpetion thrown if Encryption Fails
                //res = password;

            }


            return res;
    }
      public static CrudOperationResult<PasswordResetData> ResetPassword(string userId)
      {
        return new IdentityStoreRepo().ResetUserPassword(userId);
      }

    public static bool BlockAllUserAccountExceptOnSuperAdmin(int blockIfUserExceeds)
        {
            bool res = ((IdentityStoreRepo)new IdentityStore().DataSource).BlockAllUsersExceptSuperAdmin(blockIfUserExceeds);
            return res;
        }


    public CrudOperationResult<IdentityStore> BlockUser()
    {
      CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
      res.IsSuccess = false;
      res.Message = $"An attempt to block {Key} login account Failed!";
      res.Data = this;
      try
      {
        bool blockSuccess = ((IdentityStoreRepo)DataSource).BlockUser(this);
        res.IsSuccess = blockSuccess;
        if (blockSuccess)
        {
          // Reassign ticket to another user
          // string[] defaulter = OrgAppSetting.GetDefaultersAccount();
          //
          // string sel = defaulter[new Random().Next(0, defaulter.Length)];
          // bool success = Slot.SwapSlotWith(Key, sel);
          //Notification.NotifyAdminUsers($"{DisplayName ?? ""} ({Key}) Account has been blocked. ", NotificationConstants.CONTEXT_TYPE_USER_MANAGEMENT, Key);



          res.Message = $"'{Key}' Account has been blocked.";
        }
      }
      catch (Exception err)
      {
        res.ServerException = err;

      }

      return res;

    }
    public CrudOperationResult<IdentityStore> UnBlockUser()
    {
      CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
      res.IsSuccess = false;
      res.Message = $"An attempt to unblock {Key} login account Failed!";
      res.Data = this;
      try
      {
        bool blockSuccess = ((IdentityStoreRepo)DataSource).UnBlockUser(this);
        res.IsSuccess = blockSuccess;
        if (blockSuccess)
        {
          //Notification.NotifyAdminUsers($"{DisplayName ?? ""} ({Key}) Account has been Unblocked. ", NotificationConstants.CONTEXT_TYPE_USER_MANAGEMENT, Key);

          res.Message = $"'{Key}' Account has been unblocked.";
        }
      }
      catch (Exception err)
      {
        res.ServerException = err;

      }

      return res;

    }


    public CrudOperationResult<IdentityStore> ChangePassword(string old, string newPassword)
        {
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            res.IsSuccess = false;
            res.Message = $"An attempt to change '{Key}' login PASSWORD Failed!";
            // Let check if changing of passwords for non admin users is allowed]
            res = ((IdentityStoreRepo)DataSource).ChangePassword(this, old, newPassword);

            return res;

        }
        public static int CountTotalUsers()
        {
            return ((IdentityStoreRepo)new IdentityStore().DataSource).CountTotalUsersAccount();
        }
        public static Task<int> CountTotalUsersAsync()
        {
            return
                Task.Factory.StartNew(() =>
                {
                    return CountTotalUsers();
                });

        }
        public IdentityStore()
        {
            Gender = AppConstants.GENDER_MALE;


        }

        private IEnumerable<IdentityPreference> preferences = new List<IdentityPreference>();

        public IEnumerable<IdentityPreference> Preferences
        {
            get { return preferences; }
            internal set { preferences = value; }
        }

        internal static string DecryptPassword(string password)
        {
            string res = password;
            try
            {
                string pwd = CryptoSecure.DecryptString(encryptionKey, password);
                res = pwd;
            }
            catch (Exception)
            {


            }


            return res;
        }
        public string SecurityQuestion { get; set; }
        public string SecurityAnswer { get; set; }
        public string Email { get; set; } // Ensure this Unique if assigned
        public string ActivationCode { get; set; }
        public string DisplayName { get; set; }
        public string ObjType { get; set; }
        public string PictureUrl { get; set; }
        public string CreatedBy { get; set; }
        public string PhoneNumber { get; set; }  // Ensure this Unique if assigned
        public string Gender { get; set; }
        public string ChannelId { get; set; }

      public string Department { get; set; }
      public string ExtraData1 { get; set; }
      public string ExtraData2 { get; set; }
      public string ExtraData3 { get; set; }
      public string ExtraData4 { get; set; }

      // public string OrgId { get; set; }
        public string Password { get; set; }
        public bool IsBlocked { get; set; }
        public DateTime? DateOfBirth { get; set; }

        public bool Exist()
        {
            return IsFound(this);
        }
        public static bool IdentityExist(string userId)
        {
            return new IdentityStore() { Key = userId }.Exist();
        }
        internal void CreateNewIdentity()
        {
            this.SaveSelf(this);
        }
        internal Task CreateNewIdentityAsync()
        {
            return this.SaveSelfAsync(this);
        }
        internal void CreateNewIdentity(bool updateIfFound)
        {
            this.SaveSelf(this, updateIfFound);
        }
        internal Task CreateNewIdentityAsync(bool updateIfFound)
        {
            return this.SaveSelfAsync(this, updateIfFound);
        }
        public override DefRepository<IdentityStore> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<IdentityStore>.DataSource ?? new IdentityStoreRepo();
        }

        public static IdentityStore GetUserIdentity(string userId)
        {
            return new IdentityStore().Find(userId);
        }
        public static IEnumerable<IdentityStore> GetUserIdentity(IdentityStoreCriteria criteria)
        {
            return new IdentityStore().Find(criteria);
        }

        public CrudOperationResult<IdentityStore> Create()
        {
            return CreateObject(this);
        }
        public CrudOperationResult<IdentityStore> CreateOrUpdate()
        {
            return CreateOrUpdateObject(this);

        }

    public CrudOperationResult<IdentityStore> UpdateObjectFields(IdentityStoreCriteria criteria)
    {
      return UpdateObject(this, criteria);
    }
    public static CrudOperationResult<IdentityStore> GetIdentity(string userId)
        {
            return new IdentityStore().FindObject(userId);
        }
        public static CrudOperationResult<IEnumerable<IdentityStore>> GetIdentity(IdentityStoreCriteria criteria)
        {
            return new IdentityStore().FindObject(criteria);
        }
        public static CrudOperationResult<IdentityStoreName> GetUserName(string userId)
        {
            return ((IdentityStoreRepo)new IdentityStore().DataSource).GetUserNames(userId);
        }
        public static Task<CrudOperationResult<IdentityStoreName>> GetUserNameAsync(string userId)
        {
            return Task.Factory.StartNew(() =>
            {
                return GetUserName(userId);
            });
        }
        public static Task<IdentityStore> GetUserIdentityAsync(string userId)
        {
            return new IdentityStore().FindAsync(userId);
        }
        public static Task<IEnumerable<IdentityStore>> GetUserIdentityAsync(IdentityStoreCriteria criteria)
        {
            return new IdentityStore().FindAsync(criteria);
        }

        public override IValidationError Validate()
        {
            ValidationErrorLog errors = new ValidationErrorLog();
            // Ensure we have a valid name for warehouse
            bool hasName = !string.IsNullOrWhiteSpace(DisplayName),
                hasKey = !string.IsNullOrWhiteSpace(Key) && (Key.Length >= 4 && Key.Length <= 30),
            hasPassword = !string.IsNullOrWhiteSpace(Password) && (Password.Length >= 6 && Password.Length <= 30);
            if (!hasName)
            {
                errors.AddError("Display Name", "Please Enter a Name for this Profile, eg: Alfred Obialo");
            }
            if (!hasKey)
            {
                errors.AddError("Unique Identity", "A Unique User Identity is required for this Profile and must be between 4 and 30 characters");
            }
            if (hasKey)
            {
                if (!Key.ToLower().StartsWith("judge") && this.ObjType != AppConstants.SYS_ADMIN_ACCOUNT)
                {
                    errors.AddError("User Id Issue", "Judges User Id Must start with 'Judge and a number'");
                }
                if (Key.ToLower() == "effectiv" || Key.ToLower() == "cashnetpay" || Key.ToLower() == "brickmoney" || Key.ToLower() == "stepupright" || Key.ToLower() == "asom" || Key.ToLower() == "asomservices" ||
                    Key.ToLower() == "skoologic")
                {
                    errors.AddError("Blacklisted User Id", "You are not allowed to use any of these words as user id : ASOM, ASOM Services, Skoologic and Effectiv. Please Try again");
                }
                string res = Key.ToLower();
                const string regExPattern = @"^([A-Za-z]+[A-Za-z0-9]+)$";
                Regex reg = new Regex(regExPattern, RegexOptions.IgnoreCase);
                var newMatch = reg.Match(res);
                if (!newMatch.Success)
                {
                    errors.AddError("Symbols or Space not Allowed", "A valid User Id must start with letters and can optionally include numbers. Please Try again");
                }
            }



            if (!hasPassword)
            {
                errors.AddError("Password Field", "Password is required for this Profile and must be between 6 and 30 characters");
            }
            return errors;
        }
        IEnumerable<Role> roles = new RoleList();
        public IEnumerable<Role> Roles
        {
            get { return roles; }
            set { roles = value; }
        }

        public bool IsAuthenticated { get; set; }
        public string Location { get; set; }
        public string State { get; set; }
        public string SerialNo { get; set; }

        public bool IsInRole(string role)
        {
            throw new NotImplementedException();
        }

        public void SetPreference(IEnumerable<IdentityPreference> defaultPreferences)
        {
            var identityPreferences = defaultPreferences as IdentityPreference[] ?? defaultPreferences.ToArray();
            foreach (var p in identityPreferences)
            {
                p.IdentityId = Key;
            }
            Preferences = identityPreferences;

        }

        public CrudOperationResult<IdentityStore> Drop()
        {
            return DeleteObject(this);

        }

        public static bool IsUserBlocked(string userId)
        {
            return ((IdentityStoreRepo)new IdentityStore().DataSource).IsUserBlocked(userId);
        }

        public static bool IsActivatedFor(string userId)
        {
            return ((IdentityStoreRepo)new IdentityStore().DataSource).IsUserActivated(userId);
        }
        public static bool ActivateUser(string userId)
        {
            return ((IdentityStoreRepo)new IdentityStore().DataSource).ActivateUser(userId);
        }

        public static Task<CrudOperationResult<string>> GetUserPasswordAsync(string userId)
        {
            return Task.Factory.StartNew(() =>
            {
                return new IdentityStoreRepo().GetUserPassword(userId);
            });
        }
    }
    public class IdentityStoreRepo : SqlServerDal<IdentityStore>
    {
        // Overriding functions
        public override CrudOperationResult<IdentityStore> CreateObject(IdentityStore obj)
        {
            // check for validation
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            res.Data = obj;
            res.IsSuccess = false;

            try
            {
                if(obj.ObjType != AppConstants.SYS_ADMIN_ACCOUNT)
                {
                    ValidateUserAuthority(AppPermissions.CORE_APP_FUNCTIONS_MANAGER);
                }
                
                IEmailSettings email = OrgAppSetting.GetEmailSettings();
                bool useActivationProcess = email.SendEmail == true;

                obj.ActivationCode = UniqueCodeGenerator.GetActivationCode();
              obj.IsOn = true; // !useActivationProcess;
              
                identity_store e = toEntity(obj);


                // Make account active if the current User has access to admin functions
                bool hasAdminPrevilieage = HasAuthority(AppPermissions.AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE);
                if (hasAdminPrevilieage)
                {
                    obj.IsOn = true;
                }



                if (obj.Exist())
                {
                    // Also Ensure email not taken
                    //res.IsSuccess = false;
                    res.Message = "User Identity Already Exist";
                    // Also Check for unique email address and Phone number
                    return res;
                }
                // check for unqiue email
                if (!string.IsNullOrEmpty(obj.Email))
                {
                    bool isNotUniqueEmail = db.identity_store.Where(x => string.IsNullOrEmpty(x.email_address) == false).Any(x => x.email_address == obj.Email);
                    if (isNotUniqueEmail)
                    {
                        res.Message = $"The Email address : {obj.Email} is already taken";
                        return res;
                    }
                }


                db.identity_store.Add(e);

                Save();
                res.IsSuccess = true;

                res.Message = "New User Identity Created";

            }
            catch (UnAuthorizeException err)
            {
                res.Message = "You are not authorize to create Judges Accounts";
                res.ServerException = err;
                res.IsAuthorize = false;
            }
            catch (Exception err)
            {

                res.HasException = true;
                res.Message = "Internal Data Server Error : Identity Creation Aborted";
                res.ServerException = err;

            }

            return res;
        }
        public CrudOperationResult<IdentityStore> RegisterUserObject(IdentityStore obj)
        {
            IEmailSettings email = OrgAppSetting.GetEmailSettings();
            bool useActivationProcess = email.SendEmail == true;

            obj.ActivationCode = UniqueCodeGenerator.GetActivationCode();
            obj.IsOn = !useActivationProcess;
            obj.ObjType = AppConstants.SYS_USER_ACCOUNT;
            // check for validation
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            res.Data = obj;
            res.IsSuccess = false;

            identity_store e = toEntity(obj);
            try
            {
                // Validate Permission
                //TODO : REMOVE ADMIN CHECK WHEN CREATING USER ACCOUNT
                //                if (obj.ObjType != AppConstants.SYS_ADMIN_ACCOUNT)
                //                {
                //                    //ValidateUserAuthority;
                //                    ValidateUserAuthority(AppPermissions.AUTHORIZATION_CREATE_USERS);
                //                }

                // Let's check if the Identity already created
                if (obj.Exist())
                {
                    // Also Ensure email not taken
                    //res.IsSuccess = false;
                    res.Message = "User Identity Already Exist";
                    // Also Check for unique email address and Phone number
                    return res;
                }
                // check for unqiue email
                /*if (string.IsNullOrEmpty(obj.Email))
                {
                    res.Message = "A valid Email address is required";
                    return res;
                }*/
                // check for unqiue email
                /*if (!string.IsNullOrEmpty(obj.Email))
                {
                    bool isNotUniqueEmail = db.identity_store.Where(x => string.IsNullOrEmpty(x.email_address) == false).Any(x => x.email_address == obj.Email);
                    if (isNotUniqueEmail)
                    {
                        res.Message = $"The Email address : {obj.Email} is already taken";
                        return res;
                    }
                }*/

                db.identity_store.Add(e);
                res.Data = obj;
                Save();
                res.IsSuccess = true;

                res.Message = "New User Identity Created";

            }
            catch (UnAuthorizeException err)
            {
                res.Message = "You are not authorize to create User Accounts";
                res.ServerException = err;
                res.IsAuthorize = false;
            }
            catch (Exception err)
            {

                res.HasException = true;
                res.Message = "Internal Data Server Error : Identity Creation Aborted";
                res.ServerException = err;

            }

            return res;
        }
        public override CrudOperationResult<IdentityStore> FindObject(object id)
        {
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            //res.Data = obj;
            res.IsSuccess = false;
            try
            {
                IdentityStore obj = Get(id);
                if (obj != null)
                {
                    res.IsSuccess = true;
                    res.Data = obj;
                    res.Message = "Identity Loaded";
                }
                else
                {
                    res.Message = "Identity Record not Found!";
                }


            }
            catch (Exception err)
            {

                res.IsSuccess = false;
                res.Message = "Internal Server Error Occured. Please check exception log";
                res.ServerException = err;
            }
            return res;
        }
      public static CrudOperationResult<PasswordResetData> ResetPassword(string userId)
      {
        return new IdentityStoreRepo().ResetUserPassword(userId);
      }
    internal int CountSuperAdminAccount()
        {
            int res = db.identity_store.Count(x => x.obj_type == AppConstants.SYS_ADMIN_ACCOUNT);
            return res;
        }
        internal int CountTotalUsersAccount()
        {
            int res = db.identity_store.Count();
            return res;
        }
        public override CrudOperationResult<IEnumerable<IdentityStore>> FindObject(Criteria criteria)
        {
            CrudOperationResult<IEnumerable<IdentityStore>> res = new CrudOperationResult<IEnumerable<IdentityStore>>();
            res.Data = new List<IdentityStore>();
            res.Message = "Could not get List of Users";
            res.IsSuccess = false;
            res.IsAuthorize = false;
            try
            {

                // Validate Authority
                ValidateUserAuthority(new string[]
                {
                    AppPermissions.AUTHORIZATION_EDIT_USERS_ACCOUNT,
                    AppPermissions.AUTHORIZATION_CREATE_USERS}, PermissionValidationOperators.AND);
                List<IdentityStore> lst = new List<IdentityStore>();
                IEnumerable<identity_store> data = new List<identity_store>();
                if (criteria != null && criteria is IdentityStoreCriteria)
                {
                    IdentityStoreCriteria isc = criteria as IdentityStoreCriteria;
                    //                    isc.QueryString = isc.QueryString.ToLower().Trim();
                    if (!isc.LoadOnlyAdmin)
                    {
                        if (isc.IncludeAdmin)
                        {

                            data = db.identity_store.OrderBy(x => x.display_name)
                                .ThenBy(x => x.date_created);
                        }
                        else
                        {
                            data = db.identity_store
                                .Where(x => x.obj_type != AppConstants.SYS_ADMIN_ACCOUNT)
                                .OrderBy(x => x.display_name)
                                .ThenBy(x => x.date_created);
                        }
                        if (!string.IsNullOrEmpty(isc.QueryString))
                        {
                            data =
                                data.Where(
                                    x =>
                                        x.display_name.ToLower().Contains(isc.QueryString.ToLower()) || x.user_id.ToLower().Contains(isc.QueryString.ToLower()));
                        }
                    }
                    else
                    {
                        data = db.identity_store
                                .Where(x => x.obj_type == AppConstants.SYS_ADMIN_ACCOUNT)
                                .OrderBy(x => x.display_name)
                                .ThenBy(x => x.date_created);

                        if (!string.IsNullOrEmpty(isc.QueryString))
                        {
                            data =
                                data.Where(
                                    x =>
                                        x.display_name.ToLower().Contains(isc.QueryString.ToLower()) || x.user_id.ToLower().Contains(isc.QueryString.ToLower()));
                        }
                    }


                    if (isc.GetByIsActive)
                    {
                        data = data.Where(x => x.is_active == isc.ActiveState);
                    }
                    if (isc.GetByIsBlocked)
                    {
                        data = data.Where(x => x.is_blocked == isc.BlockedStatus);
                    }
                    if (isc.GetByChannel)
                    {
                        data = data.Where(x => x.channel_id == isc.ChannelId);
                    }
                    if (isc.GetByObjectType)
                    {
                        data = data.Where(x => x.obj_type == isc.ObjectType);
                    }
                    if (isc.GetByGender)
                    {
                        data = data.Where(x => x.gender == isc.Gender);
                    }
                    if (isc.GetByDateCreatedRange)
                    {
                        data = data.Where(x => x.date_created
                                               >= isc.DateInterval.StartDate && x.date_created
                                               <= isc.DateInterval.EndDate);
                    }

                    data = isc.Paginate(data);
                    lst.AddRange(data.Select(x => fromEntity(x, false))); //  Delegate Call
                    res.Data = lst;
                    res.IsSuccess = true;
                    res.Message = "All User record matching your query is returned.";
                    res.Criteria = criteria;
                    res.IsArray = true;
                    res.IsAuthorize = true;
                }

            }
            catch (UnAuthorizeException err)
            {
                res.IsSuccess = false;
                res.Message = $"Could not get User Accounts for Editting. {err.Message}";
                res.ServerException = err;
            }
            catch (Exception err)
            {
                res.IsSuccess = false;
                res.Message = "Internal Server Error Occured. Please check exception log";
                res.ServerException = err;

            }
            return res;
        }
    public CrudOperationResult<IdentityStoreName> GetUserNames(string userId)
    {
      CrudOperationResult<IdentityStoreName> res = new CrudOperationResult<IdentityStoreName>();

      res.Message = "Could not get User Profile";
      res.IsSuccess = false;
      res.IsAuthorize = false;
      try
      {


        var data = db.identity_store.Where(x => x.user_id == userId)
            .Select(x => new IdentityStoreName()
            {
              ChannelId = x.channel_id,
              DisplayName = x.display_name,
              Gender = x.gender,
              IsActive = x.is_active,
              IsBlocked = x.is_blocked,
              Location = x.location,
              UserId = x.user_id,
              PictureUrl = x.picture_url,
              Email  = x.email_address
            });
        if (data.Any())
        {
          res.Data = data.First();


          res.IsSuccess = true;
          res.Message = "User Profile loaded";



        }


      }

      catch (Exception err)
      {
        res.IsSuccess = false;
        res.Message = "Internal Server Error Occured. Please check exception log";
        res.ServerException = err;

      }
      return res;
    }
    public override CrudOperationResult<IdentityStore> DeleteObject(IdentityStore obj)
        {
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            res.Data = obj;
            res.IsSuccess = false;
            try
            {
                ValidateUserAuthority(AppPermissions.AUTHORIZATION_DROP_USERS_ACCOUNT);
                // TODO : Prevent Deleting of super admin Accounts
                if (obj.ObjType == AppConstants.SYS_ADMIN_ACCOUNT)
                {
                    res.Message = "System Admin Account can't be deleted, You can onlly Block them. this will prevent USER CONTEXT ERROR when dealing with  Sensitive data!";
                }
                else
                {
                    this.Delete(obj);
                    res.IsSuccess = true;
                    res.Message = "User Identity Deleted Successfully!";
                }

            }
            catch (UnAuthorizeException err)
            {
                throw new UnAuthorizeException("You are not authorize to Drop a user Login Account Profile");
            }
            catch (Exception err)
            {
                res.IsSuccess = false;
                res.Message = "Internal Server Error Occured. Please check exception log";
                res.ServerException = err;

            }
            return res;

        }

    public override CrudOperationResult<IdentityStore> UpdateObject(IdentityStore obj, Criteria criteria)
    {
      CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
      res.Data = obj;
      res.IsSuccess = false;
      ValidationErrorLog errors = new ValidationErrorLog();
      try
      {
        if (criteria is IdentityStoreCriteria)
        {
          IdentityStoreCriteria cri = criteria as IdentityStoreCriteria;
          var data = db.identity_store
            .FirstOrDefault(x => x.user_id == obj.Key);
          if (data != null)
          {
            if (cri.UpdateProfilePicture)
            {
              data.picture_url = obj.PictureUrl;

            }
            if (cri.UpdateDisplayName)
            {
              data.display_name = obj.DisplayName;

            }
            if (cri.UpdateEmail)
            {
              if (!string.IsNullOrEmpty(obj.Email))
              {
                bool isNotUniqueEmail = db.identity_store
                  .Where(x => string.IsNullOrEmpty(x.email_address) == false)
                  .Any(x => x.email_address == obj.Email && x.user_id != obj.Key);
                if (isNotUniqueEmail)
                {
                  errors.AddError("Email Address Taken", $"The Email address : {obj.Email} is already taken");

                }
                else
                {
                  data.email_address = obj.Email;

                }
              }


            }

            if (cri.UpdateBlockedStatus)
            {
              data.is_blocked = cri.BlockedStatus;
              obj.IsBlocked = cri.BlockedStatus == true;
            }

            if (cri.UpdatePassword)
            {
              data.password = IdentityStore.EncryptPassword(obj.Password);
            }

            Save();
            res.Message = $"Identity Profile Updated {(errors.ErrorLogs.Any() ? $"we have {errors.ErrorLogs.Count()} issues with this update" : "")}";
            res.IsSuccess = true;
            res.Data = obj;
            res.ValidationErrors = errors;
            res.Criteria = criteria;
          }



        }
      }
      catch (Exception err)
      {
        res.IsSuccess = false;
        res.Message = "Internal Server Error Occured. Please check exception log";
        res.ServerException = err;

      }
      return res;
    }

    public  CrudOperationResult<string> GetUserPassword(string userId)
        {
            CrudOperationResult<string> res = new CrudOperationResult<string>();
            res.Message = "Password Not found OR user Id  not valid";
            res.IsSuccess = false;
            try
            {
                if (!string.IsNullOrEmpty(userId))
                {
                    var data = db.identity_store.FirstOrDefault(x => x.user_id == userId.Trim());
                    if (data != null)
                    {
                        // Check for accurate USER ID comparism
                        if (data.user_id == userId)
                        {
                            res.Data = fromEntity(data,false).Password;
                            res.IsSuccess = true;
                            res.Message = "Password verification successful";
                        }
                        else
                        {
                            res.Message = "User Record not found. Please try again!";
                        }
                    }
                }

            }

            catch (Exception err)
            {
                res.IsSuccess = false;
                res.Message = "Internal Server Error Occured. Please check exception log";
                res.ServerException = err;

            }
            return res;

        }
        public override CrudOperationResult<IdentityStore> UpdateObject(IdentityStore obj)
        {
            CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
            res.Data = obj;
            res.IsSuccess = false;
            try
            {
                var data = db.identity_store.FirstOrDefault(x => x.user_id == obj.Key);
                if (data != null)
                {
                    // delete
                    toEntity(data, obj);
                    db.SaveChanges();
                    res.IsSuccess = true;
                    res.Message = "Identity Profile Updated!";
                }
                else
                {
                    res.Message = "Identity record not found!";
                }
            }
            catch (Exception err)
            {
                res.IsSuccess = false;
                res.Message = "Internal Server Error Occured. Please check exception log";
                res.ServerException = err;

            }
            return res;
        }

        public override void Save(IdentityStore obj)
        {
            identity_store e = toEntity(obj);
            db.identity_store.Add(e);
            Save();
        }

        public override bool IsFound(IdentityStore obj)
        {
            bool success = false;
            if (obj == null)
            {
                throw new Exception("No User Info Supplied");
            }
            try
            {

                success = db.identity_store.Any(x => x.user_id == obj.Key);
            }
            catch (Exception err)
            {


            }

            return success;
        }

        //        public override void Delete(IdentityStore obj)
        //        {
        //            var data = db.identity_store.FirstOrDefault(x => x.user_id == obj.Key);
        //            if (data != null)
        //            {
        //                db.identity_store.Remove(data);
        //                Save();
        //            }
        //        }

        public override IdentityStore Get(object id)
        {

            IdentityStore res = new IdentityStore() { Id = id };
            var data = db.identity_store.FirstOrDefault(x => x.user_id == res.Key);
            if (data != null)
            {
                res = fromEntity(e: data);

            }
            else
            {
                res = null;
            }
            return res;
        }

        public override IEnumerable<IdentityStore> Get(Criteria criteria)
        {
            List<IdentityStore> res = new List<IdentityStore>();
            IEnumerable<identity_store> data = new List<identity_store>();
            if (criteria != null && criteria is IdentityStoreCriteria)
            {
                IdentityStoreCriteria isc = criteria as IdentityStoreCriteria;
                data = db.identity_store.OrderByDescending(x => x.date_created)
                    .ThenBy(x => x.display_name);
                if (isc.GetByIsActive)
                {
                    data = data.Where(x => x.is_active == isc.ActiveState);
                }
                if (isc.GetByIsBlocked)
                {
                    data = data.Where(x => x.is_blocked == isc.BlockedStatus);
                }
                if (isc.GetByChannel)
                {
                    data = data.Where(x => x.channel_id == isc.ChannelId);
                }
                if (isc.GetByObjectType)
                {
                    data = data.Where(x => x.obj_type == isc.ObjectType);
                }
                if (isc.GetByGender)
                {
                    data = data.Where(x => x.gender == isc.Gender);
                }
                if (isc.GetByDateCreatedRange)
                {
                    data = data.Where(x => x.date_created
                    >= isc.DateInterval.StartDate && x.date_created
                    <= isc.DateInterval.EndDate);
                }

                data = isc.Paginate(data);
                res.AddRange(data.Select(x => fromEntity(x, false)));  //  Delegate Call
            }

            return res;
        }
      public CrudOperationResult<PasswordResetData> ResetUserPassword(string userId)
      {
        CrudOperationResult<PasswordResetData> res = new CrudOperationResult<PasswordResetData>();
        res.Message = "User Details not found!";
        res.IsSuccess = false;
        try
        {
          var userCrud = IdentityStore.GetIdentity(userId);
          if (userCrud.IsSuccess)
          {
            // check if the user is blocked
            string newPwd = UniqueCodeGenerator.NewRandomPassword();
            // change password
            var pawdChangedCrud = ChangePassword(userCrud.Data, userCrud.Data.Password, newPwd);
            if (pawdChangedCrud.IsSuccess)
            {
              var data = new PasswordResetData
              {
                Id = userCrud.Data.Key,
                Email = userCrud.Data.Email,
                HasEmail = !string.IsNullOrEmpty(userCrud.Data.Email),
                Password = newPwd

              };
              res.Data = data;
              res.IsSuccess = true;
              res.Message = "Password Reset Successful.";
            }
            else
            {
              res.Message = "Password Reset Failed! Please Try again.";
            }
          }
        }
        catch (Exception err)
        {
          res.ServerException = err;

        }

        return res;
      }
    public override void Update(IdentityStore obj)
        {
            var data = db.identity_store.FirstOrDefault(x => x.user_id == obj.Key);
            if (data != null)
            {
                toEntity(data, obj);
                Save();
            }
        }

  

        private identity_store toEntity(IdentityStore obj)
        {
            return toEntity(new identity_store(), obj);
        }

        protected virtual identity_store toEntity(identity_store e, IdentityStore obj)
        {
            e.activation_code = obj.ActivationCode;
            e.channel_id = obj.ChannelId;
            e.created_by = obj.CreatedBy;
            e.date_created = obj.DateInitialized;
            e.date_of_birth = obj.DateOfBirth;
            e.display_name = obj.DisplayName;
            e.email_address = obj.Email;
            e.gender = obj.Gender;
            e.is_active = obj.IsOn;
            e.is_blocked = obj.IsBlocked;
            e.obj_type = obj.ObjType;
            e.org_id = obj.OrgId;
            e.password = IdentityStore.EncryptPassword(obj.Password);
            e.phone_number = obj.PhoneNumber;
            e.security_answer = obj.SecurityAnswer;
            e.security_question = obj.SecurityQuestion;
            e.user_id = obj.Key;
            e.display_name = obj.DisplayName;
            e.picture_url = obj.PictureUrl;
            e.location = obj.Location;

            e.state = obj.State;
            return e;
        }
        protected virtual IdentityStore fromEntity(identity_store e, bool includePreference)
        {
            IdentityStore res = new IdentityStore();
            res.Key = e.user_id;
            res.DisplayName = e.display_name;
            res.ObjType = e.obj_type;
            res.OrgId = e.org_id;
            res.Password = IdentityStore.DecryptPassword(e.password);
            res.PhoneNumber = e.phone_number;
            res.PictureUrl = e.picture_url;
            res.SecurityAnswer = e.security_answer;
            res.SecurityQuestion = e.security_question;
            res.ActivationCode = e.activation_code;
            res.IsBlocked = e.is_blocked ?? false;
            res.IsOn = e.is_active;
            res.ChannelId = e.channel_id;
            res.CreatedBy = e.created_by;
            res.DateOfBirth = e.date_of_birth;
            res.Email = e.email_address;
            res.Gender = e.gender;
            res.DateInitialized = e.date_created;
            res.Location = e.location;
            res.State = e.state;

            //            if (string.IsNullOrEmpty(e.seriol_no))
            //            {
            //                e.seriol_no =/* UniqueCodeGenerator.GetActivationCode();*/
            //                db.SaveChanges();
            //            }
            //            res.SerialNo = e.seriol_no;
            //            res.Roles = Role.GetRoles(res);
            // Set Preferences
            if (includePreference)
            {
                res.Preferences = IdentityPreference.GetForUser(res);
                if (res.Preferences.Count() < AppDefaultPreference.DefaultPreferences.Count())
                {
                    // Install Preferences
                    IdentityPreference.CreateDefaultPreference(res, AppDefaultPreference.DefaultPreferences);
                    res.SetPreference(AppDefaultPreference.DefaultPreferences);
                }

            }

            return res;
        }
        protected virtual IdentityStore fromEntity(identity_store e)
        {

            return fromEntity(e, true);
        }

        public bool BlockAllUsersExceptSuperAdmin(int blockIfUserExceeds)
        {
            int countUsers = CountTotalUsersAccount();
            bool res = false;
            if (countUsers > blockIfUserExceeds)
            {
                var users = db.identity_store.Where(x => x.obj_type != AppConstants.SYS_ADMIN_ACCOUNT);
                foreach (var u in users)
                {
                    u.is_blocked = true;

                }
                var adminUsers = db.identity_store.Where(x => x.obj_type == AppConstants.SYS_ADMIN_ACCOUNT);
                if (adminUsers.Count() > 1)
                {
                    var blockThis = adminUsers.Take(adminUsers.Count() - 1);
                    foreach (var ad in blockThis)
                    {
                        ad.is_blocked = true;

                    }
                }

                Save();
                res = true;
            }
            return res;
        }
        public bool BlockUser(IdentityStore userIdentity)
        {

            bool res = false;
            try
            {
                //                ValidateUserAuthority(AppPermissions.AUTHORIZATION_BLOCK_USERS_ACCOUNT);
                var user = db.identity_store.FirstOrDefault(x => x.user_id == userIdentity.Key);
                if (user != null)
                {
                    if (user.obj_type == AppConstants.SYS_ADMIN_ACCOUNT)
                    {
                        // ensure we have at least one admin account that is unblocekd
                        if (CountSuperAdminAccount() > 1)
                        {
                            var totalActiveAdminAcc = db.identity_store
                                .Count(x => x.obj_type == AppConstants.SYS_ADMIN_ACCOUNT && x.is_blocked == false);
                            if (totalActiveAdminAcc > 1)
                            {
                                // we can block the admin  account
                                user.is_blocked = true;
                                Save();
                                res = true;
                            }
                        }
                        else
                        {
                            throw new UserContextException("You cannot block a SuperAdmin Account! at the momemnt");
                        }
                    }
                    else
                    {
                        // block without further checks
                        user.is_blocked = true;
                        Save();
                        res = true;
                    }
                }
                else
                {
                    throw new UserContextException("User Account not Found");
                }
            }
            catch (UnAuthorizeException err)
            {
                throw new UnAuthorizeException("You are not authorize to Block or Unblock a user Login Account Profile");
            }
            catch (Exception err)
            {

                throw new UserContextException("Could Not block current User");

            }

            return res;
        }

        public bool UnBlockUser(IdentityStore userIdentity)
        {

            bool res = false;
            try
            {
                //                ValidateUserAuthority(AppPermissions.AUTHORIZATION_BLOCK_USERS_ACCOUNT);
                var user = db.identity_store.FirstOrDefault(x => x.user_id == userIdentity.Key);
                if (user != null)
                {
                    // block without further checks
                    user.is_blocked = false;
                    Save();
                    res = true;

                }
            }
            catch (UnAuthorizeException err)
            {
                throw new UnAuthorizeException("You are not authorize to Block or Unblock a user Login Account Profile");
            }
            catch (Exception err)
            {

                throw new UserContextException("Could Not un block current User");

            }

            return res;
        }
      public CrudOperationResult<IdentityStore> ChangePassword(IdentityStore obj, string oldPassword, string newPassword)
      {
        CrudOperationResult<IdentityStore> res = new CrudOperationResult<IdentityStore>();
        res.Data = obj;
        res.IsSuccess = false;
        ValidationErrorLog error = new ValidationErrorLog();
        try
        {

          // reload the userProfile
          var user = IdentityStore.GetUserIdentity(obj.Key);  //   db.identity_store.FirstOrDefault(x =>x.user_id  == obj.Key);
          var appSettings = OrganizationInfo.GetSettings();


          if (user != null)
          {

            // is a valid user
            // ensure user profile is active and not blocked
            if ((user.IsOn == true) && !user.IsBlocked)
            {
              if (user.ObjType != AppConstants.SYS_ADMIN_ACCOUNT)
              {

                if (appSettings.BlockPasswordChange ?? false)
                {
                  // Ensure current user is not an Admin
                  res.Message =
                    "You are not Allowed to change your Password. Contact System Admin for more detail.";
                  return res;
                }
              }

              // check if the oldPassword matches the new One
              if (user.Password != oldPassword)
              {
                // Bad password Password, so update
                res.Message = "We have some Issues with Data!, Review the following";

                // ensure Password are okay
                error.AddError("Old Password Mismatch", "Your old password did not match up correctly, specify your old PASSWORD!");
              }
              if (string.IsNullOrEmpty(newPassword) || newPassword.Length < 6)
              {
                error.AddError("Password Length", "Password Length must exceed 5 Characters in length!");
              }
              res.ValidationErrors = error;
              if (!error.ErrorLogs.Any())
              {
                // success PASS
                // change the password
                user.Password = newPassword;
                res = user.UpdateObjectFields(new IdentityStoreCriteria() { UpdatePassword = true });

              }

            }
            else
            {
              res.Message =
                "You can't change your Login password if your account is either INACTIVE or BLOCKED. Please contact the appropirate authority on how to resolve this issue.";

            }

            //also  check if users are allowed to change there passwords

          }

        }
        catch (Exception err)
        {
          res.IsSuccess = false;
          res.Message = "Internal Server Error Occured. Please check exception log";
          res.ServerException = err;

        }
        return res;
      }

      public bool IsUserBlocked(string userId)
      {
        bool res = true;
        try
        {
          var firstOrDefault = db.identity_store.FirstOrDefault(x => x.user_id == userId);
          if (firstOrDefault != null)
            res = firstOrDefault.is_blocked ?? true;

        }
        catch
        {

        }



        return res;
      }

      public bool IsUserActivated(string userId)
      {
        bool res = false;
        try
        {
          var firstOrDefault = db.identity_store.FirstOrDefault(x => x.user_id == userId);
          if (firstOrDefault != null)
            res = firstOrDefault.is_active ?? false;

        }
        catch
        {

        }



        return res;
      }

    public bool ActivateUser(string userId)
        {
            bool res = false;
            try
            {
                var firstOrDefault = db.identity_store.FirstOrDefault(x => x.user_id == userId);
                if (firstOrDefault != null)
                {
                    firstOrDefault.is_active = true;
                    //                    firstOrDefault.seriol_no  = UniqueCodeGenerator.GetActivationCode();
                    Save();
                    res = true;
                }


            }
            catch
            {

            }



            return res;
        }
    }
  public class PasswordResetData
  {
    public string Id
    { get; set; }

    public string Email { get; set; }
    public bool HasEmail { get; set; }
    public string Password { get; set; }
  }

  public class IdentityStoreName

  {
    public string Location { get; set; }
    public string UserId { get; set; }
    public string DisplayName { get; set; }
    public string ChannelId { get; set; }
    public bool? IsActive { get; set; }
    public bool? IsBlocked { get; set; }
    public string PictureUrl { get; set; }
    public string Gender { get; set; }
    public string Email { get; set; }
    public bool HasEmail => !string.IsNullOrEmpty(Email);
  }

}
