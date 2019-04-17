
/// <reference path="../../jquery-1.10.2.intellisense.js" />
/// <reference path="../../ng/angular.js" />
var effectiv = window.effectiv || {};
effectiv.appName = 'ebaam'; // effectiv business and accounting management
effectiv.urls = {

    };
    effectiv.getBarcodeScannerTextbox =   function () {
      var elem  = $(":input[type=text].barcode-textbox");
      elem.focus();
      return elem;
    };
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
effectiv.http = {};


(function (ng, window) {
  effectiv.http.getRequest = function ($http, url, params) {
  return $http.get(url, {params : params}, {cache : false}) ; // returns a promise
};
  effectiv.http.postRequest = function ($http, url, data) {
    return $http.post(url, data, {cache : false}) ; // returns a promise
  };
    effectiv.appDependencies = [
        "ui.router","ui.bootstrap","ngSanitize",
        "ngAnimate", "ngAria",
        "ngMessages", "ngMaterial","ui.select",
        "asom.ui",
        "themeRollerModule","menuModule",
        "appNavModule",
        ,"settingsModule",
        "fileUploadModule","userIdentityModule",
        "signalrModule","utilModule", "dashboardModule",
        "licenseModule","dialogModule",
        "grantModule","sportsModule"

    ];

  effectiv.app = angular.module(effectiv.appName, effectiv.appDependencies)

        // .directive("asomSalesHistory",[])
        // Filters
      .filter("humanize", [HumanizeDate])
      .filter("money", ["$filter",AccountCurrency])
        // Services
        .factory("LodashService",[LodashService])
        .factory("MomentService",[MomentService])
        .factory ("data", function () {
          return {
            fetchSalesOrder : false,
            showDialog : true
          }
        })

        .factory ("$uibModalInstance", function () {
          return {
            modal : true,
            close:function (data) {

            },
            dismiss : function () {

            }
          }
        })
        .run(["$rootScope","$state", "IdentityService",RunApp])

    ;

    function HumanizeDate()
    {
        return function (dateInput, params, daysLimit) {

            var diff  = moment().diff(dateInput);
            var diff2  = moment().diff(dateInput,"days");
            var momentString  = moment.duration(diff).humanize(params);
            if(diff2>daysLimit)
            {
              momentString  = "";
            }

          return momentString
        }
    }
    function AccountCurrency($filter)
    {
      return function (money,symbol) {
        // check for negative
        if(angular.isNumber(money))
        {
          var cur  = $filter('currency')(money,"");
          if(money < 0.00)
          {
              cur = "("+cur.substring(1)+")";
          }
        }
        return cur;
      }
    }

    function RunApp(rootScope, state, identityService)
    {
        // get the Authenticated User
        rootScope.pageTitle = null;
        function NotifyThemeChanged()
        {
            $.connection.themesHub.client.themeChanged  = function(theme) {
//                alert("CHANGE!!");
                Toast.pullUp("Application theme has change to " + theme.name + " theme. ",false, 8000);

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
        rootScope.currentUser  = {};
        identityService.getCurrentUser(false)
            .then(function(response)
            {

                if(response.data.success)
                {
                    rootScope.currentUser  = response.data.data;
                    rootScope.$broadcast("currentUserLoaded",{currentUser : rootScope.currentUser});
                }
                else{
                    Toast.pullDown(response.data.message);
                }
            });
        rootScope.$on("$viewContentLoading" , function(evt, viewConfig)
        {

          Toast.showProgress();
            ////.log(viewConfig);
            ////(viewConfig);
        });
        rootScope.$on("$stateChangeSuccess" , function(evt, toState, toParams, fromState, fromParams)
        {
            //console.log("FROM RootScope.on()",toState,"To State", toParams,"To Params", fromState,"From State", fromParams,"From Params");
            rootScope.toState  = toState;
            rootScope.toParams  = toParams;
            rootScope.fromState  = fromState;
            rootScope.fromParams  = fromParams;
            
            //Toast.showInfo("State Change Successful", "Page Loaded to " + toState.name);

            ////(viewConfig);
        });
        rootScope.$on("$viewContentLoaded" , function(evt)
        {
            Toast.closeProgress();
        });
        rootScope.$on("$stateNotFound" , function(stateInfo , stateParams, options){
            //(options);
            Toast.showError("Menu Function N/A","Your Version of this Software may not have the current menu functionalities installed!, You can upgrade your version to fix this problem",8000);
            stateInfo.preventDefault();

        });
        /*This event is called whenever we are transisting from one state to another
        *
        * */
        rootScope.$on("$stateChangeStart", function(evt, toState,  toParams,fromState, fromParams)
        {
            ////.log(evt, "EVENT");
            ////.log(toState,"TO STATE");
            ////.log(fromState,"FROM STATE");
            ////.log(toParams);
            ////.log(fromParams);
            ////.log(state,"STATE INFO");
            //if(toState.name == 'dashboard-state')
            //{
            //    state.go("login-state");
            //    evt.preventDefault();
            //}
            //console.log("TO STATE" , toState,"FROM STATE" ,fromState);
            //if(toState.name == "hr-state.add-employee-state" && fromState.name == "hr-state.manage-employee-state" && toParams.dialog == "1")
            //{
            //    Toast.pullDown("Dialog Should be open here");
            //    console.log(toParams);
            //    evt.preventDefault();
            //}
            identityService.isUserAuthenticated().then(function(response)
            {
                if(!response.data.success)
                {
                    Toast.pullDown("<p class='font-size-14 text-left'>Login Session Expired</p>" +
                         "<span class='pad10 text-left'>Your Login Session has expired please Login again to continue</span>  " , true, 6000, "bg-danger");
                    state.go("login-state");
                    //.log(response);
                    evt.preventDefault();
                }
                else {
                    // if the toState is Login state
                    if(toState.name == "login-state")
                    {
                        // go to dashboard state
                        state.go("dashboard-state");
                        evt.preventDefault();
                    }
                }
            }, function (status) {
                Toast.pullDown("Server Error <br/>Please Login and try again");
                evt.preventDefault();
            });


        });
    }
    function MomentService()
    {
        var m = new moment();
        return {
            moment : m
        };
    }
    function LodashService()
    {
        var lodash = _;
        return {
            lodash : lodash
        };
    }




    var objSearchCriteriaModel  = {
       findByObj : false,
        showAllRecord : true,
       queryString : null,
       searchInAllFields : false,
        currentPage : 1,
        pageSize  : 10,
        sortById : false,
        sortAscending : true
    };
    effectiv.OBJ_SEARCH_CRITERIA_MODEL = objSearchCriteriaModel;


})(angular , window);
