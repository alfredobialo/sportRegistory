/**
 * Created by USER on 8/28/2016.
 */
(function(ng,window){
  ng.module("licenseModule" ,  [ "fileUploadModule"])
    .factory("LicenseService"  , ['$http', LicenseService])
    .controller("LicenseController", ["$scope","FileUploadService","LicenseService", LicenseController ]);

  function LicenseController(scope,fileUploadService,LicenseService) {

    scope.uploadLicense  = uploadLicense;
    scope.activateLicense = activateLicense;
    scope.loading  = false;
    scope.license = {}; scope.licenseExtender = {};
    scope.uploadExtenderLicense =  uploadLicenseExtender;
    scope.applyLicenseExtender  = applyLicenseExtender;
    function uploadLicense(uploadedFile)
    {
      scope.loading  = true;
      fileUploadService.onFileUploadChange(uploadedFile, function(response){
          if(response.success)
          {
            // the upload was success full
            Toast.pullUp("License File Uploaded Successfully");
            uploadLicenseInfo();
          }
          else{
            Toast.pullDown("<p class='font-size-16'>"+response.errorMessage+"</p>");
            scope.loading  = false;
          }

      });

    }
    function uploadLicenseExtender(uploadedFile)
    {
      scope.loading  = true;
      fileUploadService.onFileUploadChange(uploadedFile, function(response){
        if(response.success)
        {
          // the upload was success full
          Toast.pullUp("License Extension Uploaded Successfully");
          // get the extender here
           getExtender();
        }
        else{
          Toast.pullDown("<p class='font-size-16'>"+response.errorMessage+"</p>");
          scope.loading  = false;
        }

      });

    }

    function  getExtender(){
      scope.loading  = true;
      LicenseService.getUploadedLicenseExtender()
        .then(function (response) {
            //
          scope.loading  = false;
          //(response);
          if(response.data.success)
          {

            // Toast.showSuccess("Extender Loaded" ,response.data.message);
            scope.licenseExtender  = response.data.data;
          }
          else {
            Toast.showError("Extender Failed" ,response.data.message);
          }

        });
    }
    function applyLicenseExtender() {
      scope.loading  = true;
      LicenseService.extendeAppLicense()
        .then(function (response) {
          //
          scope.loading  = false;
          if(response.data.success)
          {
            Toast.showSuccess("License Extension Complete" ,response.data.message,14000);
            scope.license  = response.data.data;
          }
          else {
            Toast.showError("Extender Failed" ,response.data.message, 17000);
          }

        });
    }
    function getLicenseInfo (){
      scope.loading  = true;
      LicenseService.getLicenseDetails()
        .then(function (response) {
          scope.loading  = false;
            //(response);
          if(response.data.success)
          {
            scope.license  = response.data.data;
            //scope.licenseExtender  = {};

          }
          else{
            scope.license  = response.data.data;
            Toast.pullUp( "<span class='font-size-14'>"+response.data.message+"<br></span>" +
              "<span class='font-size-12'>You may need to attach a valid license file for this application to function properly</span> ", true, 6000, 'bg-danger');
          }
        });
    }
    function uploadLicenseInfo (){
      scope.loading  = true;
      LicenseService.uploadLicense()
        .then(function (response) {
          scope.loading  = false;
          if(response.data.success)
          {
            scope.license  = response.data.data;
            // let's read the license data
            // if(scope.license.isActivated)
            // {
            //    // Refresh the browser
            //     window.location.href="http://localhost/recdot";
            // }
            // console.log(scope.license);
          }
          else{
            Toast.pullUp( "<span class='font-size-14'>"+response.data.message+"</span>", true, 6000, 'bg-danger');
          }
        });
    }
    function activateLicense()
    {
      scope.loading  = true;
      LicenseService.activateLicense()
        .then(function (response) {
          scope.loading  = false;
          if(response.data.success)
          {
            scope.license  = response.data.data;
            Toast.pullDown(response.data.message);
          }
          else{
            Toast.pullUp(response.data.message, true, 6000, 'bg-danger');
          }
        });
    }
    getLicenseInfo();
  }

  function LicenseService($http) {
    var url  =effectiv.urls.orgUrl;
    return {
      getLicenseDetails  : function () {
          return $http.get(url,{params:{key:100}});
      },
      activateLicense  : function () {
        return $http.post(url,{key:101});
      },
      uploadLicense  : function () {
        return $http.post(url,{key:102});
      },
      extendeAppLicense  : function () {
        return $http.post(url,{key:103});
      },
      getUploadedLicenseExtender  : function () {
        return $http.post(url,{key:104});
      },
    };
  }


})(angular, window);
