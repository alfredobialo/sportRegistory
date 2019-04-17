using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Configuration;
using asom.apps.inOut.core;
using asom.apps.web.inOut.Controllers.BaseControllers;
using itrex.businessObjects.model.core.LicenseApi;

namespace asom.apps.web.inOut.Models
{
    public class InOutAppInfo : List<AppInfo>
    {
        
    }

    public  class AppInfo
    {
        public const string KnownCode_EASY_Trading_NET = "easy";
        public const string KnownCode_GOLD_Green_Cash = "gold";
        public const string KnownCode_STEPUP_Right = "stepup";
        public static string GetCurrentLayoutTemplate()
        {
            // this should come from a configuration file
            string res = Properties.Settings.Default.appTemplate;
            return res;
        }
        public bool IsLicenseValid( out string msg)
        {
            bool res = false;
            var crudLic = Get.GetReadOnlyAppLicense();
            msg = "";
            if (crudLic.Success)
            {
                AsomAppLicense lic = crudLic.Data;
                if (!lic.IsLicenseStateValid())
                {
                    if (lic.IsExpired)
                    {
                        msg = "License For " + lic.AppDefinition.AppName +
                              " has Expired!. Go to Settings Menu > Attach License to attach a new license or extend your license";
                    }
                    else if (!lic.IsActivated)
                    {
                        msg = "License For " + lic.AppDefinition.AppName +
                              " is Currently not Activated. Go to Settings Menu > Attach License";
                    }

                    res = false;
                }
                else
                {
                    res = true;
                }

            }
            else
            {
                msg = "NO Valid License for this Application, Please Attach a license file to continue using this software. Go to Settings Menu > Attach License";
            }

            return res;
        }
        /// <summary>
        /// Check if the app license has the specified feature key and value present
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="featureKey"></param>
        /// <param name="expectedValue"></param>
        /// <returns></returns>
        public bool LicenseHasValidFeature(out string msg, string featureKey, string expectedValue)
        {
            bool res = IsLicenseValid(out msg);
            if (res)
            {
                // Open the license file
                var crud = this.GetReadOnlyAppLicense();
                if (crud.Success)
                {
                    AsomAppLicense lic = crud.Data;
                    AppLicenseFeature feature;
                    bool keyFound  = lic.ExtenderFeatureSet.TryGetKnownFeature(featureKey, out feature);
                    if (keyFound)
                    {
                        // read the feature
                        if (feature.Value == expectedValue.ToLower())
                        {
                            res = true;
                            msg = "";
                        }
                        else 
                        {
                            res = false;
                            msg = $"{lic.HostComponentId} does not support the requested function {featureKey.ToUpper()}, you may need to upgrade to a higher version";
                        }
                    }
                }
                // Check if feature is available

            }
            return res;
        }

        public bool LicenseHasValidIntegerFeature(out string msg, string featureKey, out int integerValue)
        {
            integerValue = 0;
            bool res = IsLicenseValid(out msg);
            if (res)
            {
                // Open the license file
                var crud = this.GetReadOnlyAppLicense();
                if (crud.Success)
                {
                    AsomAppLicense lic = crud.Data;
                    AppLicenseFeature feature;
                    bool keyFound  = lic.ExtenderFeatureSet.TryGetKnownFeature(featureKey, out feature);
                    if (keyFound)
                    {
                        // read the feature

                        if (int.TryParse(feature.Value, out integerValue))
                        {
                            res = true;
                            msg = "";
                        }
                        else
                        {
                            res = false;
                            msg =
                                $"{lic.HostComponentId} could not read from {featureKey.ToUpper()} value. The may not be in a valid state";
                        }
                    }
                    else
                    {
                        msg = "License Key not valid !";
                    }
                }
                // Check if feature is available

            }
            return res;
        }

        public string DisplayLicenseInfoIfNeccessary()
        {
            var crudLic = Get.GetReadOnlyAppLicense();
            string msg = "";
            if (crudLic.Success)
            {
                AsomAppLicense lic = crudLic.Data;
                if (lic.IsLicenseStateValid())
                {
                    // Check if days remaing is short 
                    if (lic.DaysRemaining <= 10 && !lic.IsExpired)
                    {
                        msg = "License For " + lic.AppDefinition.AppName + " will Expire soon, " + lic.TrialDaysRemaining;
                    }
                    else if (lic.IsExpired)
                    {
                        msg = "License For " + lic.AppDefinition.AppName + " has Expired!";
                    }

                }
                else if (lic.IsExpired)
                {
                    msg = "License For " + lic.AppDefinition.AppName + " has Expired!. Go to Settings Menu > Attach License to attach a new license or extend your license";
                }
                else if (!lic.IsActivated)
                {
                    msg = "License For " + lic.AppDefinition.AppName +
                          " is Currently not Not yet Activated. Go to Settings Menu > Attach License";
                }
            }
            else
            {
                msg = "NO Valid License for this Application, Please Attach a license file to continue using this software. Go to Settings Menu > Attach License";
            }

            return msg;
        }
        private static AppInfo info  ;

        public string LICENSE_FILE_PATH = "~/uploaded_files/applicense/inout_license" +
                                          AsomAppLicenseGenetrator.LicenseFileExtention;
        public static AppInfo Get
        {
            get
            {
               
                AppInfo res = new AppInfo();
                var lic = res.GetAppLicense();
                res.LicenseFileName = "inout_license";
                res.AppName = "Coin Investment";
                res.AppTitle = "InOut Exchange Investment";
                res.AppDescription = "Start small and Earn More in a short period. InOut Invest heavy on Foreign Exchange, Oil & Gas Services, Online Marketing etc. your support to the business will yeild enormous enarnings in a short while.";
                res.AppCompanyEmail = "alfredcsdinc@gmail.com";
                res.AppCompanyPhone = "Help Desk : +01 9003 23435";
                res.AppCompanyWebsite = "http://www.inout.com";
                res.AppCompanyName = "Asom Services";
                res.AppCompanyContact = "Alfred";
                res.AppVersionCode = "2017";
                res.AppVersionNumber = 1;
                res.LicenseToCompany = lic.Success ? lic.Data?.AppDefinition?.LicenseToCompanyName : "";
                string appName = (WebConfigurationManager.AppSettings["appName"] ?? "").ToLower().Trim();
                if (!string.IsNullOrEmpty(appName))
                {
                    res.AppVersionCode = appName; 
                    if (appName.StartsWith("easy"))
                    {
                        // CEFAS
                        res.AppName = "EasyTradingNet";
                        res.AppTitle = "EasyTradingNet Investment";
                        res.AppDescription = @"Amazing networks that will enable you make money at the comfort of your home.
                            <br /> We have come to offer you exceptional service that will boost your earnings as a business man or woman, civil servant or student. <br />  Also to provide first class quality service that exceeds the expectations of our esteemed 
                            users with rapt attention to eradicating poverty. ";
                        res.icon  = MyConfig.GenerateUrlWithDomainName("images/inout/easyTradingNet_icon.png");
                        res.logo = MyConfig.GenerateUrlWithDomainName("images/inout/easyTradingNet_sm.jpg");
                        res.AppCompanyWebsite = "http://www.easytradingnet.com";
                    }
                    else  if (appName.StartsWith("gold"))
                    {
                        // CEFAS
                        res.AppName = "GoldGreenCash";
                        res.AppTitle = "GoldGreenCash";
                        res.AppDescription = @"On this platform , we pay 100% of your investment. ISN'T THAT GREAT?
                            <br />
                            Your investment will start growing on daily bases from 0-30 days immediately your 
                            <br /> payment is been confirmed by the second party.
                            you can make withdraw of your gold cash by clicking on <b>Get help</b> any day , <br /> any time of your choice within the working hours and your payment will be made immediately.


";
                        res.icon  = MyConfig.GenerateUrlWithDomainName("images/inout/goldGreenCash_icon.png");
                        res.logo = MyConfig.GenerateUrlWithDomainName("images/inout/goldGreenCash_sm.jpg");
                        res.AppCompanyWebsite = "http://www.goldgreencash.com";
                    }
                }
               res.icon = MyConfig.GenerateUrlWithDomainName("images/inout/btc_icon.png");
              res.logo = MyConfig.GenerateUrlWithDomainName("images/inout/logo.jpg");
        return res;
            }
        }
        public ServerResponseModel GetReadOnlyAppLicense()
        {


            /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                string licenseFilePath = LICENSE_FILE_PATH; //"~/uploaded_files/applicense/inout_license" + AsomAppLicenseGenetrator.LicenseFileExtention;
                HttpContext ctx = HttpContext.Current;
                string serverPath = ctx.Server.MapPath(licenseFilePath);
                // Open the license
                AsomAppLicense lic = AsomAppLicenseGenetrator.OpenLicenseFileForRead(serverPath);
                // ensure a valid license for this app was uploaded
                if (AsomAppLicense.IsValidKeyFor("inOut", lic))
                {
                    res.Success = true;
                    res.Message = lic.AppDefinition.AppName + ", License TO : " +
                                  lic.AppDefinition.LicenseToCompanyName;
                    res.Data = lic;
                }
                else
                {
                    res.Message = "License File is not a valid for inOut";
                    res.Success = false;
                }

            }
            catch (Exception err)
            {
                res.Message = err.Message;
                res.ServerException = err;
            }
            return res;
            //            }


        }
        public  ServerResponseModel GetUploadedExtender()
        {
            
          
        /*This will open the installed license if found for validation*/
        ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                string licenseFilePath = "~/uploaded_files/applicense/ext/extender_inOut_license" + AsomAppLicenseGenetrator.LicenseExtenderFileExtension;
                HttpContext ctx  = HttpContext.Current;
                string serverPath = ctx.Server.MapPath(licenseFilePath);
                // Open the license
                var lic = AsomAppLicenseGenetrator.OpenLicenseExtender(serverPath);
                // ensure a valid license for this app was uploaded
               
                    res.Success = true;
                    res.Message = $"License Extender for {lic.HostComponentId} Loaded";
                    res.Data = lic;
                

            }
            catch (Exception err)
            {
                res.Message = "Could Not Find a Valid License Extender file, Please try and Upload an extender.";
                res.ServerException = err;
            }
            return res;
            //            }
            

        }
        public ServerResponseModel GetAppLicense()
        {


            /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                // We Read from the uploaded file to check if is valid for this app and in a valid state
                // Before proceeding ....
                // Currenly the file is being overridden if not valid
                string licenseFilePath = LICENSE_FILE_PATH; //"~/uploaded_files/applicense/inOut_license" + AsomAppLicenseGenetrator.LicenseFileExtention; ;
                HttpContext ctx = HttpContext.Current;
                string serverPath = ctx.Server.MapPath(licenseFilePath);
                // Open the license
                AsomAppLicense lic = AsomAppLicenseGenetrator.OpenLicenseFromDisk(serverPath);
                res.Data = lic;
                // ensure a valid license for this app was uploaded
                if (AsomAppLicense.IsValidKeyFor("inOut", lic))
                {
                    if (!string.Equals(Path.GetExtension(serverPath), AsomAppLicenseGenetrator.LicenseFileExtention, StringComparison.OrdinalIgnoreCase))
                    {
                        res.Message =
                            $"Not a Valid License File valid license Ends with {AsomAppLicenseGenetrator.LicenseFileExtention} file Extension)";
                        res.Success = false;
                        return res;
                    }
                    // Check if the License is Expired , Blocked
                    if (lic.IsExpired && lic.IsActivated)
                    {
                        res.Message =
                            $"The License {lic.HostComponentId} cannot be used because it has EXPIRED !! (date :{lic.ExpiresOn.ToLongDateString()})";
                        res.Success = false;
                    }
                    else
                    {
                        res.Success = true;
                        res.Message = lic.AppDefinition.AppName + ", License TO : " +
                                  lic.AppDefinition.LicenseToCompanyName;
                        res.Data = lic;
//                        // remane the license to reflect the main license file
//                        // get the temp_license file if exist
//                        if (File.Exists(serverPath))
//                        {
//                            // rename file
//                            File.Copy(serverPath, ctx.Server.MapPath(AppInfo.Get.LICENSE_FILE_PATH), true);
//                            //                            File.Delete(serverPath);
//                        }

                    }

                }
                else
                {
                    res.Message = "License File is not a valid for This SOFTWARE !!!";
                    res.Success = false;
                }

            }
            catch (Exception err)
            {
                res.Message = "Could Not Find a Valid License or License file may be invalid or blocked";
                res.ServerException = err;
            }
            return res;
            //            }


        }
        public  ServerResponseModel GetUploadedAppLicense()
        {
            
          
        /*This will open the installed license if found for validation*/
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                // We Read from the uploaded file to check if is valid for this app and in a valid state
                // Before proceeding ....
                // Currenly the file is being overridden if not valid
                string licenseFilePath = "~/uploaded_files/applicense/temp_inOut_license" + AsomAppLicenseGenetrator.LicenseFileExtention;
                HttpContext ctx  = HttpContext.Current;
                string serverPath = ctx.Server.MapPath(licenseFilePath);
                // Open the license
                AsomAppLicense lic = AsomAppLicenseGenetrator.OpenLicenseFromDisk(serverPath);
                // ensure a valid license for this app was uploaded
                if (AsomAppLicense.IsValidKeyFor("inOut", lic))
                {
                    if (!string.Equals(Path.GetExtension(serverPath) , AsomAppLicenseGenetrator.LicenseFileExtention,StringComparison.OrdinalIgnoreCase))
                    {
                        res.Message =
                            $"Not a Valid License File valid license Ends with {AsomAppLicenseGenetrator.LicenseFileExtention} file Extension)";
                        res.Success = false;
                        return res;
                    }
                    // Check if the License is Expired , Blocked
                    if (lic.IsExpired && lic.IsActivated)
                    {
                        res.Message =
                            $"The License {lic.HostComponentId} cannot be used because it has EXPIRED !! (date :{lic.ExpiresOn.ToLongDateString()})  or  BLOCKED !!!";
                        res.Success = false;
                    }
                    else
                    {
                        res.Success = true;
                        res.Message = lic.AppDefinition.AppName + ", License TO : " +
                                  lic.AppDefinition.LicenseToCompanyName;
                        res.Data = lic;
                        // remane the license to reflect the main license file
                          // get the temp_license file if exist
                        if (File.Exists(serverPath))
                        {
                            // rename file
                            File.Copy(serverPath, ctx.Server.MapPath(LICENSE_FILE_PATH),true);
//                            File.Delete(serverPath);
                        }

                    }
                    
                }
                else
                {
                    res.Message = "License File is not a valid for This SOFTWARE !!!"  ;
                    res.Success = false;
                }

            }
            catch (Exception err)
            {
                res.Message = "Could Not Find a Valid License or License file may be invalid or blocked";
                res.ServerException = err;
            }
            return res;
            //            }
            

        }
//        static AppInfo()
//        {
//           
//
//        }

        public string LicenseToCompany { get; set; }

        public string LicenseFileName
        { get; internal set; }

        private string icon  = MyConfig.GenerateUrlWithDomainName("images/inout/inout_logo_favico.png"), logo =MyConfig.GenerateUrlWithDomainName("images/inout/inout_logo_icon.png"), logo2=MyConfig.GenerateUrlWithDomainName("images/inout/inOut_logo.png");
        public string AppDefaultImage { get {return MyConfig.GenerateUrlWithDomainName("images/user_avar_female.png"); } }

        #region Properties
                public string AppName { get; set; }
                public string AppDescription { get; set; }
                public string AppTitle { get; set; }

                public string  AppIconUrl { get { return icon; } }
                public string AppLogoUrl { get {return logo ; } }
                public string AppLogoGrayUrl { get {return logo2; } }
                public string AppCompanyName { get; set; }
                public string AppCompanyContact { get; set; }

                public string AppCompanyPhone { get; set; }
                public string AppCompanyWebsite { get; set; }
                public string AppCompanyEmail { get; set; }
        
                public int AppVersionNumber { get; set; }
                public string AppVersionCode { get; set; }

        #endregion


        public string DefaultAvarter(string gender)
        {
            gender =  !string.IsNullOrEmpty(gender)? gender.ToUpper().Trim()  : "MALE";
            string res = MyConfig.GenerateUrlWithDomainName("images/user_avar_male.png");
            if (gender == AppConstants.GENDER_FEMALE)
            {
                res = MyConfig.GenerateUrlWithDomainName("images/user_avar_female.png");
            }
            return res;
        }
        public string DefaultAvarter()
        {
            string res = MyConfig.GenerateUrlWithDomainName("images/user_avar_male.png");
            return res;
        }

        public ServerResponseModel ExtendAppLicense()
        {
            ServerResponseModel res = new ServerResponseModel();
            //            if (User.Identity.IsAuthenticated)
            //            {
            try
            {
                // We Read from the uploaded file to check if is valid for this app and in a valid state
                // Before proceeding ....
                // Currenly the file is being overridden if not valid
                string licenseFilePath = "~/uploaded_files/applicense/ext/extender_inOut_license" + AsomAppLicenseGenetrator.LicenseExtenderFileExtension;
                HttpContext ctx = HttpContext.Current;
                string serverPath = ctx.Server.MapPath(licenseFilePath  );
                // Open the license

                // check if the Extender if valid
                if (File.Exists(serverPath))
                {
                    AsomAppLicense lic;
                    string msg = "";
                    res.Success = AsomAppLicenseGenetrator.ExtendLicense(
                     ctx.Server.MapPath(Get.LICENSE_FILE_PATH),serverPath, out msg, out lic);
                    res.Message = msg;
                    res.Data = lic;

                }
                else
                {
                    res.Message = "Extender File Not found! Upload an Extender file to continue";
                    res.Success = false;
                }
               
            }
            catch (Exception err)
            {
                res.Message = "Could Not Find a Valid License or License file may be invalid or blocked";
                res.ServerException = err;
            }
            return res;
        }
    }                                                                                    
} 