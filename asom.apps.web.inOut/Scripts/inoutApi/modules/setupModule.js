/**
 * Created by USER on 1/13/2016.
 */
(function(ng, window){
  var getValidationTemplate =  function (crudOpResult) {
    var hasErrors  = crudOpResult.validationErrors  && crudOpResult.validationErrors.errorLogs.length >0;

    var concat =  "<p class='divider'> Please review the following issues</p>" ;
    if(hasErrors)
    {
      var eTitle = "";
      for(var i=0 ; i<crudOpResult.validationErrors.errorLogs.length;i++)
      {
        var error  = crudOpResult.validationErrors.errorLogs[i];
        eTitle  += "<i class='ion-checkmark font-size-18' ></i> &nbsp; <span class='bold'>" +error.fieldName +
          "</span> <br /> <span class='pad10 font-size-14'>" + error.hint+"</span> <p class='divider'></p>";

      }
      concat = concat + eTitle;
    }

    var markup  = "<div class='text-left'>" +
      "<span class='font-size-14'><i class='ion-ios-bell-outline font-size-28'></i>  &nbsp;&nbsp;  " +crudOpResult.message+"</span>" +
      ( hasErrors ? concat : "" )+

      "</div>";
    return markup;
  };
    ng.module("setupModule", [
       "userIdentityModule"
      ])
      .controller("SetupController", ["$scope",
        "RoleManagerService", "SetupService",
        "IdentityService"
        ,SetupController])
      .factory("SetupService", ["$http",SetupService]);

    function SetupController(scope, RoleService, SetupService,IdentityService) {


      scope.processing  = false;
      scope.processingMessage  = "Installing";
      scope.databaseConfig =
      {
        serverName : ".\\SQLEXPRESS",
        userId  : null,
        password  : null,
        databaseName : "accounting_database"
      };
      scope.userInfo = {
        userId  : null,
        displayName  : null,
        password1 : null,
        password2 : null
      };

      scope.stage   = 0;  // License Agreement
      // scope.stage   = 1;  // Install Database
      // stage 2 // Install Roles
      // stage 3 // Install Super Admin Account
      // stage 4 // Install Chart Of Account
      // stage 5 // Install Helper Utils

      scope.acceptLicense = acceptLicense;
      scope.rejectLicense  = function () {
        scope.stage  = -1;
      };
      scope.readLicense  = function () {
        scope.stage  = 0;
      };
      function acceptLicense ()
      {
        if(confirm("Do you accept our license terms?")) {
          scope.stage = 1;
          installAppRoles();
        }

      }

      scope.installDatabase = installDb;
      function installDb() {
        // Toast.debug(scope.databaseConfig);
        // return;
        if(confirm("Please Confirm your inputs and accept or cancel this action if you need to modify any record"))
        {
          scope.processing  = true;
          scope.processingMessage  = "Installing Application Database";
            SetupService.installDatabase(scope.databaseConfig)
              .then(function (response) {
                  scope.processing  = false;
                if(response.data.success)
                {
                  Toast.closePullDown();
                  Toast.showInfo("Database Installation","<p class='font-size-15'>"+ response.data.message+"</p>",20000);
                 scope.stage  = 2;

                  // Install Application default  Roles
                  installAppRoles();

                }
                else{
                  Toast.pullDown(getValidationTemplate(response.data), true, 333,"bg-danger");
                }
              });
        }
      }
      function installAppRoles() {
        Toast.pullDown("Installing Roles", false, 8000);
        scope.processing  = true;
        scope.processingMessage  = "Installing Application Security System";
        RoleService.installApplicationRoles()
          .then(function (response) {
            scope.processing  = false;
              // check if successfull
             if(response.data.success)
             {

               Toast.showInfo("Security Installation Complete","<p class='font-size-15'>"+ response.data.message+"</p>",15000);
               scope.stage =2;  // Next Stage (Install Sys Admin Account)
             }
             else{
               Toast.pullDown("<p class='font-size-15'>Application Role Installation FAILED! : "+ response.data.message + "</p>", true, 1000, 'bg-danger');
             }
          })
      }
      scope.createAdminAccount   = createDefaultAdminAccount;
      function createDefaultAdminAccount() {
        // Install when button is clicked
        // validate all input
        scope.processing  = true;
        scope.processingMessage  = "Creating System Admin Account";
        IdentityService.createSysAdminAcc(scope.userInfo)
          .then(function (response) {
            scope.processing  = false;
            if(response.data.success)
            {
              Toast.showInfo("Admin Setup Complete","<p class='font-size-15'>"+ response.data.message+"</p>",15000);
              scope.stage =3;  // Next Stage (Install Chart Of Account)

            }
            else{
              Toast.pullDown("<p class='font-size-15'>"+ response.data.message + "</p>", true, 1000, 'bg-danger');
            }
          })
      }
      function installChartOfAccount() {
        scope.processing  = true;
        scope.processingMessage  = "Preparing Chart Of Account";
        SetupService.installChartOfAccount()
          .then(function (response) {
            scope.processing  = false;
            // check if successfull
            if(response.data.success)
            {

              Toast.showInfo("Chart of Account Complete","<p class='font-size-15'>"+ response.data.message+"</p>",8000);
              scope.stage =5;  // Next Stage
            }
            else{
              Toast.pullDown("<p class='font-size-15'>Installation FAILED! : "+ response.data.message + "</p>", true, 1000, 'bg-danger');
            }
          })
      }

      function init()
        {

        }
        init();
    }
function SetupService($http) {

  var url = effectiv.urls.setupUrl;
  return  {
    installDatabase  : function (criteria) {
      criteria  = angular.toJson(criteria);
      return $http.post(url,{key : 1,criteria: criteria});
    },
    installChartOfAccount  : function () {

      return $http.post(url,{key : 2});
    }
  }
}


})(angular, window);
