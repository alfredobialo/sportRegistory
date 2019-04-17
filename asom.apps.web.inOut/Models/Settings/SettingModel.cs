using System;
using System.Collections.Generic;
using asom.apps.inOut.core.model.authentication;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;

namespace asom.apps.web.inOut.Models.Settings
{
    public class SettingModel :BaseModel
    {
        private  CurrencySettingModel _currencySettingModel = new CurrencySettingModel();
        public string AppThemeName { get; set; } = "Libration";
        //public string OrgId { get; set; } = OrganizationInfo.ORG_CODE;
        public bool? BlockPasswordChange { get; set; } = false;
        public byte? AllowedFailedLoginAttempt { get; set; } = 3;

        public CurrencySettingModel CurrencySetting
        {
            get { return _currencySettingModel; }
            set { _currencySettingModel = value; }
        }
        
       
       
        public string SmtpPortNumber { get; set; }
        public string SmtpServerAddress { get; set; }
        public string SmtpUserId { get; set; }
        public string SmtpPassword { get; set; }
        public string SmsGatewayAddress { get; set; }
        public string SmsGatewayPassword { get; set; }
        public string SmsUserId { get; set; }

        public string TransactionLabel { get; set; } = "Transaction Centre";
        public string GetHelpLabel { get; set; } = "GET HELP";
        public string ProvideHelpLabel { get; set; } = "PROVIDE HELP";
        public decimal? StakeMultiple { get; set; } = 0;

        public bool? SendSms { get; set; } = false;
        public bool? SendEmail { get; set; } = false;
        public string DefaultBannerUrl { get; set; }
        public string Tag1 { get; set; }
        public string Tag2 { get; set; }
        public string Tag3 { get; set; }
        public string Tag4 { get; set; }
        public int? AutoPairInterval { get; set; } = 1;   // One minute
        public bool? UseMultipleProvideHelp { get; set; } = false;
        public decimal? CompanyInterestRate { get; set; }
        public bool HasDefaultBannerUrl
        {
            get { return (!string.IsNullOrEmpty(DefaultBannerUrl)); }
        }
        public bool? UseMinMaxStakeAsFixed { get; set; } = false;
        public int? MultipleProvideHelpQueueLimit { get; set; } = 3;
        public decimal? BitcoinMinStakeAmount { get; set; } = 0.1m;
        public decimal? BitcoinStakeMultiple { get; set; } = 0m;
        public decimal? BitcoinMaxStakeAmount { get; set; } = 2;
        public decimal? BitcoinIncomePercentage { get; set; } = 50;
        public decimal? RefererPay { get; set; }
        /// <summary>
        /// At what amount will the refering User get Paid off for all referers he/she made
        /// </summary>
        public decimal? RefererPayOffThreshold { get; set; }
        public bool? IncomeArePaidDuration { get; set; } = false;
        public bool? UseMultipleAccountForAuthorization { get; set; } = false;
        public string BitcoinSymbol { get; set; } = "BTC";
        public bool? AutoGenerateGetHelpTicketForDefaulterParty { get; set; } = true;
        public static ServerResponseModel SaveSettings(SettingModel settings)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Success = false;
            res.Message = "Could not save your settings";
            try
            {
                
                OrgAppSetting data = (OrgAppSetting) settings;
                data.UpdateSettings();
                res.Success = true;
                res.Data = settings;
                res.IsAuthorize = true;

                res.Message = "Settings Updated!";
            }
            catch (Exception err)
            {
                res.Message = "An Error occurred on the server, Please error Logs for details";
                res.ServerException = err;

            }
            return res; 
        }
        public static implicit operator SettingModel(OrgAppSetting o)
        {
            SettingModel sm  =  new SettingModel();
            //sm.OrgId = o.OrgId;
            sm.AllowedFailedLoginAttempt = o.AllowedFailedLoginAttempt;
            sm.AppThemeName = o.AppThemeName;
            sm.BlockPasswordChange = o.BlockPasswordChange;
            sm.CurrencySetting.CurrencyAbbrv = o.CurrencyAbbrv;
            sm.CurrencySetting.CurrencyName = o.CurrencyName;
            sm.CurrencySetting.CurrencySymbol = o.CurrencySymbol;
            sm.ViewMode = o.ViewMode;

            
            sm.FontColorHexCode = o.FontColorHexCode;

            sm.GraceDaysToPay = o.GraceDaysToPay;
            sm.BlockRegistration = o.BlockRegistration;
            sm.IncomeMaturityDays = o.IncomeMaturityDays;
            sm.IncomePercentage = o.IncomePercentage;
            sm.MaxStakeAmount = o.MaxStakeAmount;
            sm.MinStakeAmount = o.MinStakeAmount;
            sm.UsePinForRegistration = o.UsePinForRegistration;
            sm.AutoPairPayers = o.AutoPairPayers;
            sm.BlockDefaulters = o.BlockDefaulters;
            sm.ShowInActiveAccount = o.ShowInActiveAccount;
            sm.SmtpPortNumber = o.SmtpPortNumber;
            sm.SmtpServerAddress = o.SmtpServerAddress;
            sm.SmtpUserId = o.SmtpUserId;
            sm.SmtpPassword = o.SmtpPassword;
            sm.SmsGatewayAddress = o.SmsGatewayAddress;
            sm.SmsGatewayPassword = o.SmsGatewayPassword;
            sm.SmsUserId = o.SmsUserId;
            sm.NotifyAdminOfPairedUsers = o.NotifyAdminOfPairedUsers;
            sm.TransactionLabel = o.TransactionLabel;
            sm.GetHelpLabel = o.GetHelpLabel;
            sm.ProvideHelpLabel = o.ProvideHelpLabel;
            sm.StakeMultiple = o.StakeMultiple;
            sm.SmtpPortNumber = o.SmtpPortNumber;
            sm.SmtpServerAddress = o.SmtpServerAddress;
            sm.SmtpUserId = o.SmtpUserId;
            sm.SmtpPassword = o.SmtpPassword;
            sm.SmsGatewayAddress = o.SmsGatewayAddress;
            sm.SmsGatewayPassword = o.SmsGatewayPassword;
            sm.SmsUserId = o.SmsUserId;
            sm.SendEmail = o.SendEmail;
            sm.SendSms = o.SendSms;
            sm.Tag1 = o.Tag1;
            sm.Tag2 = o.Tag2;
            sm.Tag3 = o.Tag3;
            sm.Tag4 = o.Tag4;
            sm.AutoPairInterval = o.AutoPairInterval;
            sm.UseMultipleProvideHelp = o.UseMultipleProvideHelp;
            sm.CompanyInterestRate = o.CompanyInterestRate > 1000 ? 1000 : o.CompanyInterestRate;
            sm.MultipleProvideHelpQueueLimit = o.MultipleProvideHelpQueueLimit;
            sm.UseMinMaxStakeAsFixed = o.UseMinMaxStakeAsFixed;
            sm.BitcoinIncomePercentage = o.BitcoinIncomePercentage;
            sm.BitcoinMaxStakeAmount = o.BitcoinMaxStakeAmount;
            sm.BitcoinMinStakeAmount = o.BitcoinMinStakeAmount;
            sm.BitcoinSymbol = o.BitcoinSymbol;
            sm.BitcoinStakeMultiple = o.BitcoinStakeMultiple;
            sm.AutoGenerateGetHelpTicketForDefaulterParty = o.AutoGenerateGetHelpTicketForDefaulterParty;
            sm.UseMultipleAccountForAuthorization = o.UseMultipleAccountForAuthorization;
            sm.IncomeArePaidDuration = o.IncomeArePaidDuration;
            sm.RefererPay = o.RefererPay;
            sm.RefererPayOffThreshold = o.RefererPayOffThreshold;
            if (!string.IsNullOrEmpty(MyConfig.GenerateFileUrl(o.DefaultBannerUrl)))
            {
                sm.DefaultBannerUrl = MyConfig.GenerateUrlWithDomainName(o.DefaultBannerUrl);
                
            }
            return sm;
        }

        public bool? ShowInActiveAccount { get; set; }

        public string FontColorHexCode { get; set; }

        public static ServerResponseModel ReInstallSystemRoles()
        {
            
            ServerResponseModel res  =  new ServerResponseModel();
            res.Message = "Could not Complete Role Installation.";
            res.Success = false;
            try
            {
                bool succes   = AppRoleName.InstallSystemRoles(true);
                res.Message = succes ? "Role Installation Completed Successfully" : res.Message;
                res.Success = succes;
            }
            catch (Exception err)
            {

                res.ServerException = err;
                res.Message = "Server Error Occurred, When trying to reinstall all system roles";
            }
            return res;
        }
        public static IEnumerable<SettingModel> GetSettingAppList()
        {
            return new List<SettingModel>() {OrganizationInfo.GetSettings()};
        } 
        public byte ViewMode { get; set; }

        public static explicit operator OrgAppSetting(SettingModel o)
        {
            OrgAppSetting sm  =   OrganizationInfo.GetSettings();
            //sm.OrgId = o.OrgId;
            sm.AllowedFailedLoginAttempt = o.AllowedFailedLoginAttempt;
//            sm.AppThemeName = o.AppThemeName;
            sm.BlockPasswordChange = o.BlockPasswordChange;
            sm.CurrencyAbbrv =  o.CurrencySetting.CurrencyAbbrv;
            sm.CurrencyName =   o.CurrencySetting.CurrencyName;
            sm.CurrencySymbol = o.CurrencySetting.CurrencySymbol;
           
           
            sm.FontColorHexCode = o.FontColorHexCode;
            sm.GraceDaysToPay = o.GraceDaysToPay;
            sm.BlockRegistration = o.BlockRegistration;
            sm.IncomeMaturityDays = o.IncomeMaturityDays;
            sm.IncomePercentage = o.IncomePercentage;
            sm.MaxStakeAmount = o.MaxStakeAmount;
            sm.MinStakeAmount = o.MinStakeAmount;
            sm.UsePinForRegistration = o.UsePinForRegistration;
            sm.AutoPairPayers = o.AutoPairPayers;
            sm.BlockDefaulters = o.BlockDefaulters;
            sm.ShowInActiveAccount = o.ShowInActiveAccount;
            sm.SmtpPortNumber = o.SmtpPortNumber;
            sm.SmtpServerAddress = o.SmtpServerAddress;
            sm.SmtpUserId = o.SmtpUserId;
            sm.SmtpPassword = o.SmtpPassword;
            sm.SmsGatewayAddress = o.SmsGatewayAddress;
            sm.SmsGatewayPassword = o.SmsGatewayPassword;
            sm.SmsUserId = o.SmsUserId;
            sm.NotifyAdminOfPairedUsers = o.NotifyAdminOfPairedUsers;
            sm.TransactionLabel = o.TransactionLabel;
            sm.GetHelpLabel = o.GetHelpLabel;
            sm.ProvideHelpLabel = o.ProvideHelpLabel;
            sm.StakeMultiple = o.StakeMultiple;
            sm.SendEmail = o.SendEmail;
            sm.SendSms = o.SendSms;
            sm.Tag1 = o.Tag1;
            sm.Tag2 = o.Tag2;
            sm.Tag3 = o.Tag3;
            sm.Tag4 = o.Tag4;
            sm.AutoPairInterval = o.AutoPairInterval;
            sm.UseMultipleProvideHelp = o.UseMultipleProvideHelp;
            sm.MultipleProvideHelpQueueLimit = o.MultipleProvideHelpQueueLimit;
            sm.UseMinMaxStakeAsFixed = o.UseMinMaxStakeAsFixed;
            sm.BitcoinIncomePercentage = o.BitcoinIncomePercentage;
            sm.BitcoinMaxStakeAmount = o.BitcoinMaxStakeAmount;
            sm.BitcoinMinStakeAmount = o.BitcoinMinStakeAmount;
            sm.BitcoinSymbol = o.BitcoinSymbol;
            sm.BitcoinStakeMultiple = o.BitcoinStakeMultiple;
            sm.AutoGenerateGetHelpTicketForDefaulterParty = o.AutoGenerateGetHelpTicketForDefaulterParty;
            sm.UseMultipleAccountForAuthorization = o.UseMultipleAccountForAuthorization;
            sm.IncomeArePaidDuration = o.IncomeArePaidDuration;
            sm.RefererPay = o.RefererPay;
            sm.RefererPayOffThreshold = o.RefererPayOffThreshold;
            sm.CompanyInterestRate = o.CompanyInterestRate>1000 ? 1000 : o.CompanyInterestRate;
            if (!string.IsNullOrEmpty(o.DefaultBannerUrl))
            {
                sm.DefaultBannerUrl = MyConfig.RemoveDomainName(o.DefaultBannerUrl);

            }
            return sm;
        }

        public bool? NotifyAdminOfPairedUsers { get; set; }

        public bool? UsePinForRegistration { get; set; }

        public decimal? MinStakeAmount { get; set; }

        public decimal? MaxStakeAmount { get; set; }

        public int? IncomeMaturityDays
        { get; set; }

        public decimal? IncomePercentage { get; set; }

        public bool? BlockRegistration { get; set; }

        public int? GraceDaysToPay { get; set; }

        public bool? AutoPairPayers { get; set; }

        public bool? BlockDefaulters { get; set; }
    }
}