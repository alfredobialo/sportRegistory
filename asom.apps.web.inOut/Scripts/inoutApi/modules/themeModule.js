(function(ng, win) {

                ng.module("themeRollerModule", [])
                .factory("ThemeService", ["$http", ThemeServiceFunction])
                .controller("ThemeController", ["DialogService","$rootScope","$scope", "ThemeService","OrgInfoService","HubConnectionService","RoleManagerService","IdentityService", ThemeController])

               function ThemeController(DialogService, $rootScope, scope, ThemeService,OrgService,hubService,RoleManagerService,IdentityService) {
                    //TODO Refactor Please
                   /*Refactor later to its controller*/
                   var defCurrency  = { name  : 'Naira', symbol : '=N='};
                   scope.defCurrency  = defCurrency;
                        scope.currencyConverters  = [
                            {
                                currency : {  name : 'Naira' ,symbol : '=N='},
                                value : 1 ,
                                defaultCurrency :defCurrency
                            },

                            {
                                currency : {  name : 'US Dollars' ,symbol : '$'},
                                value : 340 ,
                                defaultCurrency :defCurrency
                            },
                            {
                                currency : {  name : 'British Pounds' ,symbol : '£'},
                                value : 495 ,
                                defaultCurrency :defCurrency
                            },
                            {
                                currency : {  name : 'Biafran Pounds' ,symbol : 'Br'},
                                value : 200 ,
                                defaultCurrency :defCurrency
                            },
                        ];
                   /* =============================================*/


                scope.customerLabels = [
                  "Authors",
                  "Customers",
                   "Clients",
                    "Dealers",
                   "Donors",
                   "Guests",
                   "Members",
                   "Patients",
                    "Students",
                   "Tenants"
                ];
                scope.themes =[];//ThemeService.getAllThemes() ;
                scope.selectedTheme = {};
                   $rootScope.selectedTheme = {};
                scope.saveTheme  = saveTheme;
                scope.settings = {};
                   scope.appSettingsActive  = true;
                   scope.appThemeActive  = false;

                   // var themeHubObj  = hubService.getThemesHubConnection();
                   //themeHubObj.themeHub.client.themeChanged  = function(theme)
                   //{
                   //  Toast.pullUp(theme.name + " theme is Active" );
                   //  // scope.selectTheme(theme)
                   //    ////(theme);
                   //    scope.selectTheme(theme);
                   //    scope.$apply();
                   //};
                scope.selectSettingsTab = function(tabIndex)
                {
                  if(tabIndex == 1)
                  {
                      scope.appSettingsActive  = true;
                      scope.appThemeActive  = false;
                  }
                    else{
                      scope.appSettingsActive  = false;
                      scope.appThemeActive  = true;
                  }
                };

                 var defContent = "Email Setup on the server is working, this Email was sent for Testing purpose only," +
                   " Please do not reply this Mail";
                 scope.email = {
                   to: "alfredcsdinc@gmail.com",
                   content: defContent

                 }
                 scope.sendTestEmail = sendEmailTest;
                 function sendEmailTest(email) {
                   if (confirm(
                     "You are about to send a Test Email to Developers email address,\n do you want to proceed with this action?")
                   ) {
                     // send email
                     ThemeService.sendTestEmail(email.content || defContent)
                       .then(function (response) {
                         if (response.data.success) {
                           Toast.pullDown("Test Email was sent, Please check your Email");
                         } else {
                           Toast.pullUp(response.data.message, true, 2222, "bg-danger");
                         }
                       });


                   }
                 }
                   // var hubReady  = false;
                   // themeHubObj.connection.start()
                   //     .done(function(response){
                   //          hubReady  =true;
                   //     });
                function saveTheme()
                {

                    ThemeService.saveAppTheme(scope.selectedTheme).then(function(response)
                    {
                         var result  = angular.fromJson(response.data);
                        if(result.success)
                        {
                           Toast.pullUp("Saved Successfully <br />Theme : " + scope.selectedTheme.name + " has been saved!");
                            // Broadcast to others except me that the theme has changed
                            // if(hubReady)
                            // {
                            //     ////(scope.selectedTheme);
                            //     themeHubObj.themeHub.server.notifyThemeChanged(scope.selectedTheme );
                            // }

                        }
                        else
                        {
                            Toast.pullDown("<p class='font-size-15 text-left pad10'>"+ result.message + "</p>",false,7600);
                        }
                    });
                }

                scope.selectTheme = selectTheme;
                function selectTheme(theme) {
                    scope.selectedTheme = theme;
                    $rootScope.selectedTheme = theme;
                    makeThemeActive(theme);
                }

                function makeThemeActive(theme) {
                    angular.forEach(scope.themes, function(theme) {

                            theme.isActive = false;


                    });
                    theme.isActive = true;
                }
                scope.invoiceTemplate  = [];
                scope.loading  = false;
                scope.saveSettings = function () {
                  scope.loading= true;

                  OrgService.saveAppSettings(scope.settings)
                    .then(function (response) {
                      scope.loading= false;
                       if(response.data.success)
                       {
                          Toast.showSuccess("Settings Saved!", "Your changes was saved successfully!", 7000);
                       }
                       else {
                         Toast.showError("Oop! Failed!!" ,  response.data.message);
                       }
                    })
                };
                scope.makeTemplateActive  = mTemplateActive;
                function mTemplateActive(selectedTemplated) {
                    // make others inactive
                    // this just for the UI;
                    _.map(scope.invoiceTemplate, function(t)
                    {
                        if(t.id != selectedTemplated.id)
                        {
                          t.isActive  = false;
                        }

                    });
                    selectedTemplated.isActive= true;
                    scope.settings.invoiceTemplate  = selectedTemplated.id;
                    Toast.showInfo("Invoice Template Set!", "You have a selected the " + selectedTemplated.name +  " 'Template' if you wish to keep it, remember to save the settings!", 12000);
                }

             
                init();
                function init()
                {
                  scope.loading  = true;
                  ThemeService.getAppTheme().then(function(response){
                    // alert("Getting Themes");

                    var result  = response.data;

                    result.data = angular.fromJson(result.data);

                    var defTheme  = result.data;
                    scope.$parent.pageTitle  = defTheme.name +" Theme Configurations";
                    // Get App Settings here

                    OrgService.getSettings()
                      .then(function (response) {
                        //(response);
                        if(response.data.success)
                        {
                          scope.settings  = response.data.data;
                          // Also Get Invoice Template
                          OrgService.getInvoiceTemplate()
                            .then(function (response) {
                              scope.invoiceTemplate  = response.data.data;
                              // loop thru the collection and select a template from our settings object
                              _.map(scope.invoiceTemplate, function(t)
                              {
                                if(t.id == scope.settings.invoiceTemplate)
                                {
                                  t.isActive  = true;
                                }

                              });
                            });
                        }
                        else{
                          Toast.showError("Failed to load","App Settings has Failed to load!", 8000);
                        }
                        scope.loading  = false;

                      });

                    ThemeService.getAllThemes().then(function(response){
                      var result  = response.data;
                      //result.data = angular.fromJson(result.data);
                      scope.themes  = result;//.data;
                      ng.forEach(scope.themes,function(obj){
                        if(obj.name == defTheme.name)
                        {
                          scope.selectTheme(obj);
                          //Toast.showInfo("Theme Found","The themes matches, so select it now");
                        }
                      });



                    });
                  });
                }

                scope.patchingDb  = false;
                scope.installingRoles  = false;
                scope.backingupDatabase  = false;
                scope.restoringDatabase  = false;
                scope.confirmClearCache  =confirmCacheClear ;
                scope.confirmResetRoles  =confirmResetRoles ;
                scope.confirmPatchDb  =confirmPatchDb ;
                function confirmCacheClear(){
                    var modal=DialogService.openDialog(
                      "Please Confirm Your Action","Do you really want to Clear System CACHE?",
                      'Ok Clear Cache',
                      'No Please');





                    modal.result.then(function () {

                           Toast.showToast("Ok!", "OK Proceed With the action" );

                    }, function () {

                    });
                }
                function confirmResetRoles(){
                   var modal=DialogService.openDialog(
                     "Re-Install Roles & Permissions","Reinstall application Roles and User Permission" +
                     ". Only Execute this action when Application Security Changes from Software Updates or Patch!",
                     'Re-Install Roles',
                     'Abort!');





                   modal.result.then(function () {
                      scope.installingRoles = true;
                      RoleManagerService.installApplicationRoles()
                        .then(function (response) {
                          scope.installingRoles  = false;
                            if(response.data.success)
                            {
                                Toast.pullDown("<p class='font-size-16'>"+response.data.message+"</p>");

                            }
                            else{
                              Toast.pullUp(response.data.message);
                            }
                        })

                   }, function () {

                   });
                 }
                 function confirmPatchDb(){
                   var modal=DialogService.openDialog(
                     "Patch System Database","Do you want set the Database to Patch MODE ?. This action will Sign You Out of the system and prepare for Database Patching",
                     'Patch Database',
                     'Not now!',function () {
                       scope.patchingDb  = true;
                        IdentityService.patchDb()
                          .then(function (response) {
                            if(response.data.success)
                            {
                                Toast.pullDown("<p class='font-size-16'>"+response.data.message+"</p>")
                            }
                            else {
                                Toast.pullDown(response.data.message, false,5000,'bg-danger');
                            }
                            scope.patchingDb  = false;
                          });

                     });

                 }

            }

            function ThemeServiceFunction($http) {
                var url  =effectiv.urls.themesUrl;
                return {
                    getAllThemes: function() {
                       return  $http.get(url,{params : {module:'themes',key: 200}});

                    },
                    getAppTheme: function() {

                        return  $http.get(url,{params :{module:'themes',key: 100}});

                    },
                    saveAppTheme : function(themeObj)
                    {
                        themeObj  = angular.toJson(themeObj);
                        return  $http.post(url,{module:'themes',key : 300 , data : themeObj});
                    },

                    sendTestEmail : function(content) {
                      return $http.post(url, { key: 400, data: content });
                    }

                }

            }
        })(angular, window);
