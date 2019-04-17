/**
 * Created by USER on 1/13/2016.
 */
var effectiv = window.effectiv || {};
//effectiv.appName = 'ebaam'; // effectiv business and accounting management
effectiv.urls = {

};

(function(ng, window){

    ng.module("ebaamStartUp", ["ui.router","ngMessages","ngAnimate","userIdentityModule", "fileUploadModule","settingsModule" , "setupModule","asom.ui"])
        .config(["$stateProvider","$urlRouterProvider", StartupState])
        .run(["$rootScope",RunApp]);
    //.controller("LoginViewController", ["$scope","IdentityService",LoginViewController]);
  effectiv.getValidationTemplate =  function (crudOpResult) {
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
function RunApp(rootScope)
{
    function NotifyThemeChanged()
    {
        $.connection.themesHub.client.themeChanged  = function(theme)
        {
            Toast.showInfo("Theme Changed","Application theme has change to " + theme.name + " theme. ", 8000);

            rootScope.$apply(function(){
                rootScope.selectedTheme  = theme;
            });
        };

    }
    function InitThemeHubCon()
    {
        $.connection.hub.start();

    }
    // InitThemeHubCon();
    // NotifyThemeChanged();
}
    function StartupState(stateProvider, urlRouterProvider)
    {

        //stateProvider.state({
        //   name : "login-state",
        //    url : "/login",
        //    controller  : "LoginViewController",
        //    templateUrl  : effectiv.urls.findPartial+"/login_view"
        //});
        //urlRouterProvider.otherwise("/login");
    }


})(angular, window);
