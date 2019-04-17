/**
 * Created by Alfred Obialo of Asom Services on 1/16/2016. 0806 927 3479
 */
(function(ng,window){
    var settingsMod  = ng.module("settingsModule", [] )
        .controller("CompanyInfoController" ,["$scope","OrgInfoService","FileUploadService", CompanyInfoController])
        .controller("LogoDisplayController",["$scope","OrgInfoService", LogoDisplayController ])
        .factory("OrgInfoService", ["$http","$rootScope",OrgInfoService]);

    function LogoDisplayController(scope, orgService)
    {
        //scope.orgInfo  =orgService.getCachedInfo();
        scope.orgInfo = {};
        scope.$on("orgInfoChanged", function(evt, arg)
        {
            scope.orgInfo  = arg.data;
            //(arg.data);
        });

        //scope.orgInfo();
    }

    function CompanyInfoController(scope, orgService,fileUploadService)
    {


        scope.companyImage = {
            logo  : null,
            signature : null,
            logo2 : null
        };
        //scope.$watch("orgInfo.logoUrl", function(newval){
        //   orgService.logoUrl  = newval;
        //});
        scope.isEditMode  = false;
        scope.loading  = false, scope.uploading = false;
        scope.memento = {
            orgInfo : {},
            companyImage : {}
        };

        scope.editModeText  = scope.isEditMode ? "Save Changes" : "Edit";
        scope.$watch("isEditMode", function (newVal,oldVal ) {
            scope.editModeText  = scope.isEditMode ? "Save Changes" : "Edit";
        });
        scope.execCommand = function()
        {
            if(!scope.isEditMode) {
                scope.isEditMode = true;
                // copy
                scope.memento.orgInfo  = angular.copy(scope.orgInfo);
                scope.memento.companyImage  = angular.copy(scope.companyImage);

            }
            if(scope.editModeText == "Save Changes")
            {
                // save
                saveCompanyInfo();
            }

        };
        scope.cancelEdit  = function () {

            scope.isEditMode  = false;
            scope.orgInfo  = scope.memento.orgInfo;
            scope.companyImage  = scope.memento.companyImage;
           };
        scope.orgInfo = {};
        function saveCompanyInfo()
        {
            if(!scope.isEditMode )
            {
                alertUpdateError();
                return ;
            }
            scope.loading = true;
           orgService.saveCompanyInfo(scope.orgInfo)
                .then(function(response)
                {
                    if(response.data.success)
                    {
                        scope.memento = {
                            orgInfo : {},
                            companyImage : {}
                        };
                        orgService.getOrgInfo(scope.orgInfo);
                        scope.isEditMode  = false;
                    }

                   scope.loading = false;
                },
                function(xhr)
                {
                    scope.loading  = false;
                    Toast.showError("Error" , "Could not Save Changes, Please try again" , 10000);
                }
            );
        }
        function getCompanyInfo()
        {
            scope.loading= true;
            orgService.getCompanyInfo()
                .then(function(response){
                    //Toast.showSuccess("Company Info", response.data.message);
                    scope.orgInfo = response.data.data;
                    scope.companyImage.logo  = scope.orgInfo.logoUrl;
                    scope.companyImage.logo2  = scope.orgInfo.secondaryLogoUrl;
                    scope.companyImage.signature  =scope.orgInfo.signatureUrl;
                   // scope.$parent.pageTitle  = scope.orgInfo.name;
                    scope.loading= false;
                }, function(xhr)
                {
                    scope.loading= false;
                    Toast.showError("Error Getting Data", "Could not get requested record",10000);
                });


        }
        getCompanyInfo();
        scope.uploadLogo = function(obj) {

            //var form = obj.form;
            if (scope.isEditMode) {
                scope.uploading  = true;
                fileUploadService.onFileUploadChange(obj, function (result) {
                    if(result.success)
                    {
                        scope.$apply(function(){

                            scope.companyImage.logo = result.files[0].autoFileUrl;
                            scope.orgInfo.logoUrl  = result.files[0].name;
                            scope.uploading  = false;

                        });
                    }
                    else{
                        scope.uploading  = false;
                        Toast.showError("Failed to Upload File", result.errorMessage);
                    }

                });
            }
            else{
                alertUpdateError();
            }
        }
        scope.uploadLogo2 = function(obj) {

            var form = obj.form;
            if (scope.isEditMode) {
                scope.uploading  = true;
                fileUploadService.onFileUploadChange(obj, function (result) {
                    if(result.success)
                    {
                        scope.$apply(function(){

                            scope.companyImage.logo2 = result.files[0].autoFileUrl;
                            scope.orgInfo.secondaryLogoUrl  = result.files[0].name;
                            scope.uploading  = false;
                        });
                    }
                    else{
                        Toast.showError("Failed to Upload File", result.errorMessage);
                    }

                });

            }
            else{
                alertUpdateError();
            }
        }
        function alertUpdateError() {
            Toast.showInfo("Profile Not Editable", "Please click on edit button in the top tool bar ");
        }

        scope.uploadSignature = function(obj) {

            var form = obj.form;
            if (scope.isEditMode) {
                scope.uploading  = true;
                fileUploadService.onFileUploadChange(obj, function (result) {
                    if(result.success)
                    {
                        scope.$apply(function(){

                            scope.companyImage.signature = result.files[0].autoFileUrl;
                            scope.orgInfo.signatureUrl  = result.files[0].name;
                            scope.uploading  = false;
                        });
                    }
                    else{
                        Toast.showError("Failed to Upload File", result.errorMessage);
                    }

                });

            }
            else{
                alertUpdateError();
            }
        }
        //function iframeLoaded(iframe, callback)
        //{
        //    $(iframe).one("load", function (evt) {
        //
        //        var frameWnd = $(this).get(0).contentWindow;
        //
        //        var doc = $(frameWnd.document.body);
        //        var content = doc.text();
        //        var rawJson = angular.fromJson(content);
        //        callback(rawJson);
        //      });
        //}
    }
    function OrgInfoService($http, rootScope)
    {
        var url  =effectiv.urls.orgUrl;
        var orgInfo = {};
        return {
            getOrgInfo  : function()
            {
               if(arguments.length > 0)
               {
                   orgInfo = arguments[0];

                   rootScope.$broadcast("orgInfoChanged",{data  : orgInfo});
               }
                else{
                   return orgInfo;
               }


            },

            getCompanyInfo  : function()
            {
                return $http.get(url,{params : {module:'org-info', key : 1}} );

            },
            getSettings  : function()
            {
                return $http.get(url,{params : {module:'org-info', key : 2}});
            },
            getInvoiceTemplate  : function()
            {
              return $http.get(url,{params : { key : 40}});
            },
            saveCompanyInfo  : function(companyinfo)
            {
                //orgInfo = companyinfo;
                return $http.post(url,{module:'org-info', key : 3,data : angular.toJson(companyinfo)});
            },
            saveAppSettings  : function(settingsData)
          {
            //save app settings
            return $http.post(url,{key : 30,data : angular.toJson(settingsData)});
          },
            saveViewMode  : function(mode)
            {
                // Save settings
                return $http.post(url,{module:'org-info', key : 4,data : mode});
            },
          getBusinessChannels  : function()
          {
            // Get All Business Channels
            return effectiv.http.getRequest($http,url,{key : 5});
          },
        };
    }

})(angular,window);
