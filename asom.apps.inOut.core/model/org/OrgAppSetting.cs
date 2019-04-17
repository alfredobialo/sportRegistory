using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using asom.apps.inOut.core.dal.sqlserver.model;
using itrex.businessObjects.model.core;
using System;

namespace asom.apps.inOut.core.model.org
{
    public class OrgAppSetting : DefaultPersistable<OrgAppSetting> , IEmailSettings,ISmsSettings
    {

        public static string NAIRA = "₦";//U+20A6
        internal OrgAppSetting()
        {
            Key = OrganizationInfo.ORG_SETTING_CODE;

        }

        public static OrgAppSetting Instance()
        {
            return new OrgAppSetting();
        }

        public string CurrencyName { get; set; } = "Naira";
        public string CurrencySymbol { get; set; } = NAIRA;
        public string CurrencyAbbrv { get; set; } = "NGR";
        public string Country { get; set; } = "Nigeria";
        public string AppThemeName { get; set; } = "Libration";
        public string FontColorHexCode { get; set; } = "#000000";
        public bool? SupportBitcoin { get; set; } = false; 
        public bool? BlockPasswordChange { get; set; } = false;
        public bool? UseMultipleProvideHelp { get; set; } = false;
        public bool? UseMinMaxStakeAsFixed { get; set; } = false;
        public int? MultipleProvideHelpQueueLimit { get; set; } = 3;
        
        public byte? AllowedFailedLoginAttempt { get; set; } = 3;

        public string  BitcoinAmountRange { get; set; }
        public string CashAmountRange { get; set; }
        public bool? UseAmountRange { get; set; }

        public string GetValidAmountRange()
        {  string res = "";
            if (UseMinMaxStakeAsFixed == true)
            {
                // use the min and maxx amount as the only required amount to pay
                if (MaxStakeAmount == MinStakeAmount)
                {
                    res = $"Amount must be {MinStakeAmount.Value.ToString("N0")}";

                }
                else {
                        res = $"Amount must be Either {MinStakeAmount.Value.ToString("N0")} OR  {MaxStakeAmount.Value.ToString("N0")} {CurrencyAbbrv}";
                    }
                    
              

            }
            else
            {

                if (StakeMultiple > 0)
                {
                    if (MaxStakeAmount >= MinStakeAmount)
                    {
                        string validran = "";
                        int i = 0; 
                        var validRanges = new List<decimal?>();
                        for (decimal? m = MinStakeAmount;
                            m <= MaxStakeAmount;
                            m +=
                                StakeMultiple)
                        {

                            i += 1;
                            validRanges.Add(m);

                            validran += $" {m.Value.ToString("N0")} - ";
                        }
                        if (validRanges.Max() < MaxStakeAmount)
                        {
                            validRanges.Add(MaxStakeAmount);
                            validran += $"{MaxStakeAmount.Value.ToString("N0")}";
                        }
                       
                        res =

                            $"Amount must be any of these values  {validran} in {CurrencyAbbrv}";
                        if (i >15)
                        {
                            res = $"Amount must be any between {MinStakeAmount.Value.ToString("N0")} and {MaxStakeAmount.Value.ToString("N0")} {CurrencyAbbrv} in Multiples of {StakeMultiple:N0} {CurrencyAbbrv}";
                        }
                    }
                }
                else
                {
                    res = $"Amount must be Between  {MinStakeAmount.Value.ToString("N0")} And {MaxStakeAmount.Value.ToString("N0")} {CurrencyAbbrv}";
                }
            }

            return res;

        }
        public override DefRepository<OrgAppSetting> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<OrgAppSetting>.DataSource ?? new OrgSettingRepo();

        }

        public static OrgAppSetting Get()
        {
            //TODO :Fix here incase no valid Database Connection
            OrgAppSetting settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            if (settings == null)
            {
                new OrgAppSetting().SaveSettings();
               settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            }
            return  settings;
        }
        public static IEmailSettings GetEmailSettings()
        {
            //TODO :Fix here incase no valid Database Connection
            IEmailSettings settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            if (settings == null)
            {
                new OrgAppSetting().SaveSettings();
               settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            }
            return  settings;
        }
        public static ISmsSettings GetSmsSettings()
        {
            //TODO :Fix here incase no valid Database Connection
            ISmsSettings settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            if (settings == null)
            {
                new OrgAppSetting().SaveSettings();
               settings = new OrgAppSetting().Find(OrganizationInfo.ORG_SETTING_CODE);
            }
            return  settings;
        }
        public Task SaveSettingsAsync()
        {
           
            return SaveOrIgnoreIfExistAsync(this);
        }
        public void SaveSettings()
        {
            SaveOrIgnoreIfExist(this);
        }
        private bool Exist()
        {
            return IsFound(this);
        }

        public void UpdateSettings()
        {
            
            SaveSelf(this,true);
        }
        // 3 : card-5

        // 1 : card-4

        // 2 card-3
        public byte ViewMode { get; set; }
        public bool Save()
        {
            bool res = false;
            try
            {
                UpdateSettings();
                res = true;
            }
            catch 
            {
                
            }
           
            
            return res;
        }

        
        public bool? ShowInActiveAccount { get; set; } = false;
 
        public string SmtpPortNumber { get; set; }
        public string SmtpServerAddress { get; set; }
        public string SmtpUserId { get; set; }
        public string SmtpPassword { get; set; }
        public string SmsGatewayAddress { get; set; }
        public string SmsGatewayPassword { get; set; }
        public string SmsUserId { get; set; }

        public string DefaultBannerUrl { get; set; }
        public string Tag1 { get; set; }
        public string Tag2 { get; set; }
        public string Tag3 { get; set; }
        public string Tag4 { get; set; }
        public string CustomerLabel { get; set; } = "Members";
        public string TransactionLabel { get; set; } = "Transaction Centre";
        public string GetHelpLabel { get; set; } = "GET HELP";
        public string ProvideHelpLabel { get; set; } = "PROVIDE HELP";
        public decimal? StakeMultiple { get; set; }
        public bool? BlockDefaulters { get; set; } = false;
        public bool? AutoPairPayers { get; set; } = true;
        public bool? BlockRegistration { get; set; } = false; 
        public int? GraceDaysToPay { get; set; } = 3;
        public int? IncomeMaturityDays { get; set; } = 14;
        public decimal? IncomePercentage { get; set; } = 50;
        public int? AutoPairInterval { get; set; } =10;   // One minute
        
        public bool? UsePinForRegistration { get; set; } = false;
        public decimal? MinStakeAmount { get; set; } = 10000m;
        public decimal? MaxStakeAmount { get; set; } = 1000000m;
        public bool? NotifyAdminOfPairedUsers { get; set; } = true;
        public bool? SendSms { get; set; } = false;
        public bool? SendEmail { get; set; } = false;
        public decimal? CompanyInterestRate { get; set; }
        public decimal? BitcoinMinStakeAmount { get; set; } = 0.1m;
        public decimal? BitcoinStakeMultiple { get; set; } = 0m;
        public decimal? BitcoinMaxStakeAmount { get; set; } = 2;
        public decimal? BitcoinIncomePercentage { get; set; } = 30;
        public decimal? RefererPay { get; set; } = 2000m;

        /// <summary>
        /// At what amount will the refering User get Paid off for all referers he/she made
        /// </summary>
        public decimal? RefererPayOffThreshold { get; set; } = 30000m;
        public bool? IncomeArePaidDuration { get; set; } = false;
        public bool? UseMultipleAccountForAuthorization { get; set; } = false;
        public string BitcoinSymbol { get; set; } = "BTC";
        public bool? AutoGenerateGetHelpTicketForDefaulterParty { get; set; } = true;
  public static string[] GetCompanyTopLevelAccounts()
        {
            string[] res = null;
            var setting = Get();
            if (setting != null)
            {
                if (!string.IsNullOrEmpty(setting.Tag2))
                {
                    res = setting.Tag2.Split(new string[] {","}, StringSplitOptions.RemoveEmptyEntries);
                    res  = res.Select(x => x.Trim()).ToArray();
        }
            }
            if (res == null)
            {
                res  =  Array.Empty<string>();
            }
            return res;
        }
        public static string[] GetCompanyEmail()
        {
            string[] res = null;
            var setting = Get();
            if (setting != null)
            {
                if (!string.IsNullOrEmpty(setting.Tag1))
                {
                    res = setting.Tag1.Split(new string[] {","}, StringSplitOptions.RemoveEmptyEntries);
                  res = res.Select(x => x.Trim()).ToArray();
        }
            }
            if (res == null)
            {
                res  =  new string[] {};
            }
            return res;
        }
        public string GetValidBitcoinRange()
        {
            string res = "";
            if (UseMinMaxStakeAsFixed == true)
            {
                // use the min and maxx amount as the only required amount to pay
                if (BitcoinMaxStakeAmount == BitcoinMinStakeAmount)
                {
                    res = $"Amount must be {BitcoinMinStakeAmount.Value.ToString("N1")}";

                }
                else
                {
                    res = $"Amount must be Either {BitcoinMinStakeAmount.Value.ToString("N1")} OR  {BitcoinMaxStakeAmount.Value.ToString("N0")} {CurrencyAbbrv}";
                }



            }
            else
            {

                if (BitcoinStakeMultiple > 0)
                {
                    if (BitcoinMaxStakeAmount >= BitcoinMinStakeAmount)
                    {
                        string validran = "";
                        int i = 0;
                        var validRanges = new List<decimal?>();
                        for (decimal? m = BitcoinMinStakeAmount;
                            m <= BitcoinMaxStakeAmount;
                            m +=
                                BitcoinStakeMultiple)
                        {

                            i += 1;
                            validRanges.Add(m);

                            validran += $" {m.Value.ToString("N1")} - ";
                        }
                        if (validRanges.Max() < BitcoinMaxStakeAmount)
                        {
                            validRanges.Add(BitcoinMaxStakeAmount);
                            validran += $"{BitcoinMaxStakeAmount.Value.ToString("N1")}";
                        }

                        res =

                            $"Amount must be any of these values  {validran} in {BitcoinSymbol}";
                        if (i > 15)
                        {
                            res = $"Amount must be any between {BitcoinMinStakeAmount.Value.ToString("N1")} and {BitcoinMaxStakeAmount.Value.ToString("N1")} {BitcoinSymbol} in Multiples of {BitcoinStakeMultiple:N1} {BitcoinSymbol}";
                        }
                    }
                }
                else
                {
                    res = $"Amount must be Between  {BitcoinMinStakeAmount.Value.ToString("N1")} And {BitcoinMaxStakeAmount.Value.ToString("N1")} {BitcoinSymbol}";
                }
            }
            return res;
        }
    }


    public interface IAuthSettings
    {
        bool? BlockPasswordChange { get; set; }  
        byte? AllowedFailedLoginAttempt { get; set; }     
    }
    public interface IEmailSettings
    {
        bool? SendEmail { get; set; } 
        string SmtpPortNumber { get; set; }
        string SmtpServerAddress { get; set; }
        string SmtpUserId { get; set; }
        string SmtpPassword { get; set; }
        

    }

    public interface EmailSender
    {
        Task<CrudOperationResult<bool>> Send();
    }
    public interface ISmsSettings
    {
        bool? SendSms { get; set; } 
        string SmsGatewayAddress { get; set; }
        string SmsGatewayPassword { get; set; }
        string SmsUserId { get; set; }

    }
    public interface IViewModeSetting
    {
        byte ViewMode { get; set; }
        bool Save();

    }

    
}
