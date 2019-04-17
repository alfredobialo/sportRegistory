/**
 * Created by USER on 1/13/2016.
 */

(function (ng, window) {

    ng.module("appNavModule", [])
        .config(["$stateProvider",
            "$urlRouterProvider",
            function ($stateProvider, $urlRouterProvider) {

                /*The new URL Mapper for AJAX request */
                var subMenu = effectiv.urls.menuUrl + "?id=",// append data here
                    partials = effectiv.urls.partialsUrl + "?id="; // append data here

                var dashboard = {
                        name: "dashboard-state",
                        url: "/dashboard",
                        views: {

                            "": {
                                templateUrl: partials + "app-dashboard",
                                controller: "DashboardController"
                            },
                            "left-menu": {
                                templateUrl: subMenu + "dashboard"
                            }
                        }

                        ,
                        data: {
                            title: "Welcome Back!",
                            description: "Your Dashboard contains Summaries of all activities.",
                            iconClass: "fa fa-briefcase",
                            hasBagde: false

                        }


                    },
                    walletSettings = {

                        name: dashboard.name + ".performer-state",
                        url: "/performer-setup",
                        views: {
                            "@": {
                                templateUrl: partials + "bank-setup-partial",
                                controller : 'PerformerController',
                                data: {
                                    title: "Setup your Performer",
                                    description: "Manage Performer profile.",
                                    iconClass: "fa fa-money",
                                    hasBagde: false

                                }
                            },


                        }

                    },
                    createjudge = {
                        name: dashboard.name + ".create-judge-state",
                        url: "/judge-setup",
                        views: {
                            "@": {
                                templateUrl: partials + "registration-partial",
                                // controller : 'CustomerListController'
                                data: {
                                    title: "Setup your Judge Profile",
                                    description: "Manage Judge profile.",
                                    iconClass: "fa fa-money",
                                    hasBagde: false

                                }
                            },


                        }


                    },
                userConsoleState = {
                    // abstract : true,
                    name: "user-console-state",
                    url: "/judges-management?q",
                    views: {

                        "": {
                            // controller : "UserDashboardController",
                            controller: "RegisteredUserManagerController",
                            templateUrl: partials + "user-management-console",// partials+"user-dashboard"
                        },
                        "left-menu": {

                            templateUrl: subMenu + "user-console"
                        }
                    },
                    data: {
                        title: "Registered Judges!",
                        description: "View each Judge's profile, enable or disable accounts at will.",
                        iconClass: "fa fa-briefcase",
                        hasBagde: false

                    }


                } ,
                    userList = {

                        name: userConsoleState.name + ".active-users-state",
                        url: "/active-users?q",
                        views: {
                            "@": {
                                templateUrl: partials + "user-management-console",
                                controller: "RegisteredUserManagerController"

                            }
                            ,
                            data: {
                                title: "Registered Users!",
                                description: "View each User's profile, enable or disable accounts at will.",
                                iconClass: "fa fa-briefcase",
                                hasBagde: false

                            }

                        }

                    },


                    appSettings = {
                        // abstract : true,
                        name: "settings-state",
                        url: "/settings",
                        views: {

                            "": {
                                //controller : "SalesController",
                                template: "<div class='pad30 theme-caption-bg-color min-h100'>  " +
                                    "<h1 class='pad10 font-size-40 theme-caption-color'>" +
                                    "Application Configuration Management</h1></div>" +
                                    "</div>"

                            },
                            "left-menu": {

                                templateUrl: subMenu + "settings"
                            }
                        }
                        ,
                        data: {
                            title: "Manage Application Settings",
                            description: "Configure the look and feel of these App and also setup your defaults",
                            iconClass: "ion ion-person"
                            ,
                            hasBagde: false
                        }

                    },


                    alerts = {
                        // abstract : true,
                        name: "alert-state",
                        url: "/sys-alerts",
                        views: {

                            "": {
                                controller: "NotificationController",
                                templateUrl: partials + "sys-notify"

                            },
                            "left-menu": {

                                templateUrl: subMenu + "alerts"
                            }
                        }
                        ,
                        data: {
                            title: "Alerts",
                            iconClass: "ion ion-person"
                            ,
                            hasBagde: true
                        }

                    }

                ;

                $stateProvider
                  //  .state(alerts)
                    .state(appSettings)
                    .state(walletSettings)
                    .state(userConsoleState)
                    .state(createjudge)
                    .state(dashboard)

                ;

// Submenu State Start Here


                /// Settings Sub Menus Please Edit with care
                //start with other settings
              var  settings_other_settings = {
                    name: appSettings.name + ".other-settings-state",
                    url: "/other-settings",
                    views: {
                        "@": {
                            templateUrl: partials + "app_config"
                            , controller: "ThemeController"
                        }
                        // "left-menu" : {
                        //
                        //     templateUrl : subMenu+"settings"
                        // }
                    }

                } , settings_license = {
                    name: appSettings.name + ".license-state",
                    url: "/license-setup",
                    views: {
                        "@": {
                            templateUrl: partials + "license-setup",
                            controller: "LicenseController"
                        }
                        // "left-menu" : {
                        //
                        //     templateUrl : subMenu+"settings"
                        // }
                    }

                }
                    , settings_edit_company = {
                    name: appSettings.name + ".edit-company-state",
                    url: "/edit-company",
                    views: {
                        "@": {
                            templateUrl: partials + "edit_company",
                            controller: "CompanyInfoController"
                        }
                    }

                }
                    , settings_manage_user = {
                    name: appSettings.name + ".create-users-state",
                    url: "/manage-users",
                    views: {
                        "@": {
                            templateUrl: partials + "manage-users",
                            controller: "UserManagerController"
                        }
                    }

                }     , settings_my_profile = {
                    name: appSettings.name + ".myprofile-state",
                    url: "/edit-profile",
                    views: {
                        "@": {
                            templateUrl: partials + "my-profile",
                            controller: "MyProfileManagerController"
                        }
                    }

                }
                    , settings_manage_permission = {
                    name: appSettings.name + ".user-permission-state",
                    url: "/manage-permission",
                    views: {
                        "@": {
                            templateUrl: partials + "manage-permissions",
                            controller: "RoleManagerController"
                        }
                    }

                }
                // Sales Submenus Routes starts here

                ;
// Login view State
                var loginView_state = {
                    name: 'login-state',
                    url: '/login',
                    views: {
                        '@': {
                            controller: 'LoginViewController',
                            templateUrl: partials + "login_view"
                        },
                        "menu-title": {
                            template: "<i class='ion-ios-unlocked'></i> Login "
                        },
                        'left-menu': {
                            template: "<p class='margin-15 '></p>"
                        }

                    }
                    
                };
                $stateProvider
                    .state(loginView_state)

                    .state(settings_other_settings)
                    .state(settings_edit_company)
                    .state(settings_manage_user)
                    .state(settings_my_profile)
                    //.state(settings_license)
                    //.state(settings_manage_permission)
                     ;

                $urlRouterProvider.otherwise("/dashboard");
            }]);

})(angular, window);
