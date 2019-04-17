using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using asom.apps.inOut.core;
using asom.apps.inOut.core.model.authentication;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core.LicenseApi;
using itrex.businessObjects.model.core.util;

namespace asom.apps.web.inOut.Models.Navigation
{
    public class WebConstants
    {
        public const string BLOG = "BLOG";
        public const string CONTACT = "CONTACT";
        public const string LOGIN = "LOGIN";
        public const string REGISTER = "REGISTER";
        public const string FAQ = "FAQ";
        public const string HOME_MENU = "HOME_MENU";
        public const string ABOUT_MENU = "ABOUT_MENU";
        public const string GET_STARTED_MENU = "GET_STARTED_MENU";

        private WebConstants()
        {
        }
    }

    public class ApplicationMenuBase
    {
        private string name;

        public ApplicationMenuBase()
        {
            SubMenus = new List<SubMenuHeader>();
        }

        public string Name
        {
            get { return name; }
            set
            {
                name = value;
                if (string.IsNullOrEmpty(Key)) Key = value.ToLower();
            }
        }

        public bool IsActive { get; set; }
        public string IconCssClassName { get; set; }
        public bool HasBadge { get; set; }
        public string Url { get; set; }
        public string Key { get; set; }
        public IEnumerable<SubMenuHeader> SubMenus { get; set; }
        public bool IsVisible { get; set; }
        public int BagdeValue { get; set; }
        public int SortOrder { get; set; } //  For sorting the Menus
    }

    public interface ISubMenu
    {
        string Name { get; set; }
        bool IsActive { get; set; }
        string IconCssClassName { get; set; }
        bool HasBadge { get; set; }
        string Url { get; set; }
        bool IsNavigatable { get; }
        bool IsHead { get; set; }

        //ApplicationMenuBase MainMenu { get; set; }
    }


    public class SubMenuHeader : ISubMenu
    {
        protected bool isNavigatable = false;

        public SubMenuHeader()
        {
            IsHead = true;
            IsActive = true;
            IsVisible = true;
            Menus = new List<SubMenuChild>();
        }

        public bool IsVisible { get; set; }
        private string _name;

        public string Name
        {
            get { return _name; }
            set
            {
                _name = value;
                if (string.IsNullOrEmpty(Id))
                {
                    Id = Helper.GetPrettyUrlId(Name);
                }
            }
        }

        public string Id { get; set; }
        public bool IsActive { get; set; }
        public string IconCssClassName { get; set; }
        public bool HasBadge { get; set; }
        public string Url { get; set; }
        public bool IsHead { get; set; }
        public int SortOrder { get; set; } = 0;
        public IEnumerable<SubMenuHeader> Children { get; set; } = new List<SubMenuHeader>();
        public bool HasChildren => Children.Any();

        public bool IsNavigatable
        {
            get { return isNavigatable; }
        }

        public IEnumerable<SubMenuChild> Menus { get; set; }
    }

    public class SubMenuChild : SubMenuHeader
    {
        public SubMenuChild()
        {
            IsHead = true;
            isNavigatable = true;
        }
    }


    public class MenuManager
    {
        public static string LoginMenuUrl
        {
            get
            {
                HttpContextBase context = new HttpContextWrapper(HttpContext.Current);
                string loginUrl = UrlHelper.GenerateUrl("Auth", "index", "home", new RouteValueDictionary(),
                    RouteTable.Routes, context.Request.RequestContext, true);
                return loginUrl;
            }
        }

        public static string ALERT_MENU = "ALERT",
            ACC_MENU = "ACCOUNTING",
            HR_MENU = "HR",
            CRM_MENU = "CRM",
            PURCHASES_MENU = "PURCHASES",
            BANKING_MENU = "BANK_MANAGER",
            EXPENSE_MENU = "EXPENSE_MANAGER",
            CHANNEL_MENU = "CHANNEL",
            AUDIT_MENU = "AUDIT_TRAIL",
            WAREHOUSE_MENU = "WAREHOUSE",
            SYSTEM_CONFIG_MENU = "SYSTEM_CONFIG",
            ROLE_MANAGER_MENU = "ROLE_MANAGEMENT",
            BARCODE_MENU = "BARCODE_SCANNER";

        static MenuManager()
        {
            //CreateMenus();
        }

        IEnumerable<ApplicationMenuBase> CreateMenus()
        {
            string template = AppInfo.GetCurrentLayoutTemplate();

            List<ApplicationMenuBase> lst = new List<ApplicationMenuBase>();

            // Let Get the Installed License for this application
            // and, modify how the app reacts to APP LICENSE COMPONENT
            // var appSettings = OrganizationInfo.GetSettings();
            var crud = AppInfo.Get.GetReadOnlyAppLicense();
            AsomAppLicense license = null;
            AppLicenseFeature fea = new AppLicenseFeature();
            // if we are successful, perform the necessary checks
            if (crud.Success)
            {
                license = crud.Data;
                if (!license.IsLicenseStateValid())
                {
                    crud.Success = false;
                }
            }


            lst.Add(new ApplicationMenuBase()
            {
                Url = "dashboard-state", // Generate Dynamically base on Name of Menu
                Name = "Dashboard",
                Key = "dashboard",
                HasBadge = false,
                IsActive = true, //  is the menu is Selected
                IsVisible = true,
                SortOrder = 1,
                IconCssClassName = "fa-balance-scale",
                //SubMenus = BuildSubMenusFor("dashboard")
            });
            lst.Add(new ApplicationMenuBase()
            {
                Url = "transaction-state.ph-ticket-state", // Generate Dynamically base on Name of Menu
                Name = "Transactions",
                Key = "transactions",
                HasBadge = false,
                IsActive = false, //  is the menu is Selected
                IsVisible = true,
                SortOrder = 2,
                IconCssClassName = "fa-shopping-cart",
                //SubMenus = BuildSubMenusFor("transactions")
            });
            if (new IdentityStore().HasAuthority(AppPermissions.MANAGE_USERS))
            {
                lst.Add(new ApplicationMenuBase()
                {
                    Url = "user-console-state", // Generate Dynamically base on Name of Menu
                    Name = template == AppConstants.UI_TEMPLATE_2 ? "Registered Users" : "Users",
                    Key = "user-console",
                    HasBadge = false,
                    IsActive = false, //  is the menu is Selected
                    IsVisible = true,
                    SortOrder = 3,
                    IconCssClassName = "fa-users",
                    // SubMenus = BuildSubMenusFor("user-console")
                });
            }

            /*lst.Add(new ApplicationMenuBase()
           {
               Url = "alert-state" , // Generate Dynamically base on Name of Menu
               Name = template == AppConstants.UI_TEMPLATE_2 ? "Alerts" : "Msg",
               Key = "alerts",
               HasBadge = true,
              BagdeValue = Notification.CountOfflineNotifications().Data,
              IsActive = false, //  is the menu is Selected
               IsVisible = true,
               SortOrder = 7,
               IconCssClassName = "ion-bell",
               SubMenus = BuildSubMenusFor(Key)


           });*/


            lst.Add(new ApplicationMenuBase()
            {
                Url = "settings-state",
                Name = template == AppConstants.UI_TEMPLATE_1 ? "Settings" : "Configure",
                Key = "settings",
                HasBadge = false,
                IsActive = false, //  is the menu is Selected
                IsVisible = true,
                IconCssClassName = "ion-ios7-gear",
                SortOrder = 8,
                //SubMenus = BuildSubMenusFor(Key)
            });

////             Help Disabled for now
            lst.Add(new ApplicationMenuBase()
            {
                Url = "help-state",
                Name = "Help",
                HasBadge = false,
                IsActive = false, //  is the menu is Selected
                IsVisible = true,
                IconCssClassName = "ion-ios7-gear",
                SortOrder = 9,
            });

            return lst;
        }

        public static IEnumerable<SubMenuHeader> BuildSubMenusFor(string mainMenu)
        {
            // Get Systems Roles that could perform administrative function
            bool hasAdminAccess = new IdentityStore().HasAuthority(
                new string[] {AppPermissions.CORE_APP_FUNCTIONS_MANAGER}
            );
            // if we are successful, perform the necessary checks
            //var appSettings = OrganizationInfo.GetSettings();
            // check if the module is active
            if (!IsVisible(mainMenu))
            {
                return new List<SubMenuHeader>();
            }

            IEnumerable<SubMenuHeader> result = new List<SubMenuHeader>();
            if (mainMenu.ToLower() == "settings")
            {
                SubMenuChild adminChildMenu = new SubMenuChild(),
                    adminRole = new SubMenuChild(),
                    adminLic = new SubMenuChild();

                if (hasAdminAccess)
                {
                    adminChildMenu = new SubMenuChild()
                    {
                        Name = "Company Setup",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild()
                            {
                                Name = "Edit Company",
                                Url = "settings-state.edit-company-state"
                            },
                            new SubMenuChild()
                            {
                                Name = "Other Settings",
                                Url = "settings-state.other-settings-state"
                            },
                        }
                    };

                    adminRole = new SubMenuChild()
                    {
                        Name = "Edit User Permissions",
                        Url = "settings-state.user-permission-state",
                        IsVisible =
                            UserIdentityModel.HasAuthority(new string[]
                                {AppPermissions.AUTHORIZATION_CREATE_CUSTOM_ROLES})
                    };


                    adminLic = new SubMenuChild()
                    {
                        Name = "License Setup",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild()
                            {
                                Name = "Attach a License",
                                Url = "settings-state.license-state",
//
                            },
                        }
                    };
                }

                result = new List<SubMenuHeader>()
                {
                    adminChildMenu,
                    new SubMenuChild()
                    {
                        Name = hasAdminAccess ? "Manage Users" : "Profile Settings",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild()
                            {
                                Name = "Create / Edit Users",
                                Url = "settings-state.create-users-state",
                                IsVisible = hasAdminAccess
                            },
                            new SubMenuChild()
                            {
                                Name = "My Profile",
                                Url = "settings-state.myprofile-state",
//
                            },
                            adminRole,
                            new SubMenuChild()
                            {
                                Name = "Your Bank",
                                Url = "settings-state.bank-state",
//
                            },
                        }
                    },
                    adminLic
                };
            }
            else if (mainMenu == "dashboard")
            {
                result = new List<SubMenuHeader>()
                {
                    new SubMenuHeader
                    {
                        Name = "Sections",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild
                            {
                                Name = "News Board",
                                IsActive = false,
                            },
                            new SubMenuChild
                            {
                                Name = "Success Stories",
                                IsActive = false,
                            },
                        }
                    }
                };
            }
            else if (mainMenu == "transactions")
            {
//                foundMenu = crud.Success ? license.ExtenderFeatureSet.TryGetKnownFeature(EXPENSE_MENU, out feature) : false;
//                if (foundMenu)
//                {
//                    showMenu = feature.Value == "true" ? true : false;
//                }
                SubMenuChild adm = new SubMenuChild();
                if (hasAdminAccess)
                {
                    adm = new SubMenuChild()
                    {
                        Name = "Ticket Management",
                        IsActive = true,
                        IconCssClassName = "ion-magnet",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild()
                            {
                                Name = "Investment Tickets",
                                Url = "transaction-state.all-ph-ticket-state",
                                IsActive = true
                            },
//                            new SubMenuChild()
//                            {
//                                Name = $"Confirmed Payments Tickets",
//                                Url = "transaction-state.all-gh-ticket-state",
//                                IsActive = true
//                            },
                        }
                    };
                }

                result = new List<SubMenuHeader>()
                {
//                    new SubMenuChild()
//                    {
//                        Name = "New Ticket",
//                        IsActive = true,
//                        IconCssClassName = "ion-add",
//                        Menus = new List<SubMenuChild>()
//                        {
//                            new SubMenuChild()
//                            {
//                                Name = "Invest Here",
//                                Url = "transaction-state.ph-ticket-state",
//                                IsActive = true
//                            },
////                            new SubMenuChild()
////                            {
////                                Name = "Your Income",
////                                Url = "transaction-state.gh-ticket-state",
////                                IsActive = false
////                            },
//
//
//                        }
//
//                    },
                    adm
                };
            }

            else if (mainMenu == "user-console")
            {
                // USER Management Console
                result = new List<SubMenuHeader>()
                {
                    new SubMenuHeader()
                    {
                        Name = "Management",
                        Menus = new List<SubMenuChild>()
                        {
                            new SubMenuChild()
                            {
                                Name = "Active Registered Users",
                                Url = "user-console-state.active-users-state"
                            },
//                            new SubMenuChild()
//                            {
//                                Name = "Blocked Users",
//                                Url = "user-console-state.blocked-users-state"
//                            },
                        }
                    }
                };
            }

            // Alert Menus
            else if (mainMenu == "alerts")
            {
//                result = new List<SubMenuHeader>()
//                {
//                    new SubMenuHeader()
//                    {
//                        Name = "Important",
//                        Menus = new List<SubMenuChild>()
//                        {
//                            new SubMenuChild()
//                            {
//                                Name = "Offline Messages",
//                                Url = "alert-state.offline-message-state"
//                            },
//
//
//
//                        }
//                    },
//                    new SubMenuHeader()
//                    {
//                        Name = "Application Critical",
//                        Menus = new List<SubMenuChild>()
//                        {
//                            new SubMenuChild()
//                            {
//                                Name = "Application License Status",
//                                Url = "alert-state.app-lic-state"
//                            },
//                            new SubMenuChild()
//                            {
//                                Name = "Others",
//                                Url = "alert-state.others-state"
//                            },
//
//
//                        }
//                    }
//                };
            }

            return result;
        }

        public static bool IsVisible(string mainMenu)
        {
            mainMenu = mainMenu.ToLower();
            var applicationMenuBase = GetApplicationMainMenu().FirstOrDefault(x => x.Key.ToLower() == mainMenu);
            return applicationMenuBase != null && applicationMenuBase.IsVisible;
        }

        public static IEnumerable<ApplicationMenuBase> GetApplicationMainMenu()
        {
            var res = new MenuManager().CreateMenus().OrderBy(x => x.SortOrder);
            return res;
        }

        public static IEnumerable<SubMenuHeader> GetGrantAppMenus()
        {
            var res = new MenuManager().CreateGrantMenus().OrderBy(x => x.SortOrder);
            return res;
        }

        private IEnumerable<SubMenuHeader> CreateGrantMenus()
        {
            List<SubMenuHeader> res = new List<SubMenuHeader>();
            bool isAdmin  = new IdentityStore().HasAuthority(AppPermissions.CORE_APP_FUNCTIONS_MANAGER);

            res.Add(
                new SubMenuHeader()
                {
                    Name = "Dashboard",
                    SortOrder = 1,
                    IconCssClassName = "fa-balance-scale",
                    Id = "dashboard",
                    Menus = new List<SubMenuChild>
                    {
                        new SubMenuChild
                        {
                            Url = "dashboard-state",
                            Name = isAdmin ? "Score Board" : "Score Entry",
                            IsVisible = true
                        },
                        new SubMenuChild
                        {
                            Url = "dashboard-state.performer-state",
                            Name = "Player Setup",
                            IsVisible = isAdmin
                        },
                        new SubMenuChild
                        {
                            Url = "dashboard-state.create-judge-state",
                            Name = "Judges Account Setup",
                            IsVisible = isAdmin
                        },
                      
                    }
                }
            );

            res.Add(
                new SubMenuHeader()
                {
                    Name = "Sports Records",
                    SortOrder = 2,
                    IconCssClassName = "fa-balance-scale",
                    IsVisible = isAdmin,

                    Menus = new List<SubMenuChild>
                    {
                        new SubMenuChild
                        {
                            Url = "user-console-state",
                            Name = "All Judges",
                            IsVisible = true
                        },
                        
                    }
                }
            );

            // Check if the user is an admin user
          
            return res;
        }

        public static IEnumerable<ApplicationMenuBase> GetActiveMenu()
        {
            return GetApplicationMainMenu().Where(x => x.IsActive == true);
        }
    }
}