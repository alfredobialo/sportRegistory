using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal.sqlserver.model
{
    public class OrgSettingRepo  : SqlServerDal<OrgAppSetting>
    {
        protected internal OrgSettingRepo()
        {
            
        }

        public override bool IsFound(OrgAppSetting obj)
        {
            return db.org_global_settings.Any(x => x.id == obj.Key);
        }

        public override OrgAppSetting Get(object id)
        {
            OrgAppSetting res =  new OrgAppSetting();

            res.Id = id;
            try
            {
                var data = db.org_global_settings.FirstOrDefault(x => x.id == res.Key);
                if (data != null)
                {
                    res = fromEntity(data);
                }
                else
                {
                    res = null;
                }
            }
            catch (Exception err)
            {
                
            }
            finally
            {
                db.Database.Connection.Close();
            }
           
            
            return res;
        }

        public override void Save(OrgAppSetting obj)
        {
//            ValidateUserAuthority(AppPermissions.MANAGE_APP_SETTINGS);
            org_global_settings e = toEntity(obj);
            db.org_global_settings.Add(e);
            Save();
        }

        public override void Update(OrgAppSetting obj)
        {
//            ValidateUserAuthority(AppPermissions.MANAGE_APP_SETTINGS);
            var data = db.org_global_settings.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                toEntity(data, obj);
                Save();
            }
           
        }

        private org_global_settings toEntity(OrgAppSetting o)
        {
            return toEntity(new org_global_settings(), o);
        }

        private org_global_settings toEntity(org_global_settings e, OrgAppSetting o)
        {
            e.id = o.Key;
            e.allowed_login_attempt = o.AllowedFailedLoginAttempt;
            e.application_theme = o.AppThemeName;
            e.currency_name = o.CurrencyName;
            e.currency_name_abbrv = o.CurrencyAbbrv;
            e.currency_symbol = o.CurrencySymbol;
            e.block_failed_user_login_attempt = o.BlockPasswordChange;
            e.isActive = o.IsOn;
            e.org_id = o.OrgId;
            e.acc_show_inactive_account = o.ShowInActiveAccount ?? false;
            e.always_block_defaulters = o.BlockDefaulters ?? false;
            e.auto_pair_payers = o.AutoPairPayers ?? true;
            e.block_registration = o.BlockRegistration ?? false;
            e.grace_days_to_pay = o.GraceDaysToPay ?? 3;
            e.income_maturity_days = o.IncomeMaturityDays ?? 14;
            e.income_percentage = o.IncomePercentage ?? 50;
            e.max_stake = o.MaxStakeAmount ?? 999999999999m;
            e.min_stake = o.MinStakeAmount ?? 5m;                                                                               
            e.use_access_pin_for_registration = o.UsePinForRegistration ?? false;
            e.notify_admin = o.NotifyAdminOfPairedUsers ?? true;
            e.smpt_port = o.SmtpPortNumber;
            e.smpt_server_address = o.SmtpServerAddress;
            e.smpt_user_id = o.SmtpUserId;
            e.customer_label = o.CustomerLabel;
            e.smtp_password = o.SmtpPassword;
            e.sms_gateway_address = o.SmsGatewayAddress;
            e.sms_gateway_password = o.SmsGatewayPassword;
            e.sms_gateway_user_id = o.SmsUserId;
            e.send_sms = o.SendSms;
            e.send_email = o.SendEmail;
            e.provide_help_label = o.ProvideHelpLabel;
            e.get_help_label = o.GetHelpLabel;
            e.transaction_label = o.TransactionLabel;
            e.stake_multiple = o.StakeMultiple;
            e.default_banner_url = o.DefaultBannerUrl;
            e.tag1 = o.Tag1;
            e.tag2 = o.Tag2;
            e.tag3 = o.Tag3;
            e.tag4 = o.Tag4;
            e.auto_pair_minute_interval = o.AutoPairInterval ?? 1;

            e.support_bitcoin = o.SupportBitcoin  ?? false;
            e.company_interest_rate = o.CompanyInterestRate ?? 2.0m;
            e.use_multiple_provide_help = o.UseMultipleProvideHelp ?? false;
            e.use_min_max_stake_as_fixed_value = o.UseMinMaxStakeAsFixed ?? false;
            e.multiple_provide_help_queue_limit = o.MultipleProvideHelpQueueLimit ?? 3;
            e.bitCoinAmtRange = o.BitcoinAmountRange;
            e.cashAmtRange = o.CashAmountRange;
            e.useAmtRange = o.UseAmountRange;
            //--------------------  NEW COLUMNS ----------------------------------
            e.auto_generate_gh_ticket_for_defaulters_party = o.AutoGenerateGetHelpTicketForDefaulterParty ?? true;
            e.referer_pay = o.RefererPay ?? 2000;
            e.referer_payoff_threashold  = o.RefererPayOffThreshold?? 30000;
            e.bitcoin_interest = o.BitcoinIncomePercentage ?? 30;
            e.btc_min_amt = o.BitcoinMinStakeAmount ?? 0.1m;
            e.btc_max_amount = o.BitcoinMaxStakeAmount ?? 5m;
            e.btc_symbol = o.BitcoinSymbol ?? "BTC";
            e.required_multiple_account_for_authorization = o.UseMultipleAccountForAuthorization ?? false;
            e.only_receive_income_when_day_elapses = o.IncomeArePaidDuration ?? false;

            return e;
        }
        
        OrgAppSetting fromEntity(org_global_settings e)
        {
            OrgAppSetting res  =  new OrgAppSetting();
            res.Key = e.id;
            res.AppThemeName = e.application_theme;
            res.BlockPasswordChange = e.block_failed_user_login_attempt;
            res.AllowedFailedLoginAttempt = e.allowed_login_attempt;
            res.CurrencyAbbrv = e.currency_name_abbrv;
            res.CurrencyName = e.currency_name;
            res.CurrencySymbol = e.currency_symbol;
            res.OrgId = e.org_id;

            res.CustomerLabel = e.customer_label ?? "Customers";

            res.ShowInActiveAccount = e.acc_show_inactive_account ?? false;
            res.AutoPairInterval = e.auto_pair_minute_interval ?? 1;
             res.SmtpPortNumber= e.smpt_port;
             res.SmtpServerAddress= e.smpt_server_address;
             res.SmtpUserId= e.smpt_user_id;
             res.SmtpPassword=e.smtp_password ;
             res.SmsGatewayAddress= e.sms_gateway_address;
             res.SmsGatewayPassword= e.sms_gateway_password;
             res.SmsUserId= e.sms_gateway_user_id;
            res.GraceDaysToPay = e.grace_days_to_pay;
            res.AutoPairPayers = e.auto_pair_payers;
            res.BlockDefaulters = e.always_block_defaulters;
            res.BlockRegistration = e.block_registration;
            res.UsePinForRegistration = e.use_access_pin_for_registration;
            res.IncomeMaturityDays = e.income_maturity_days;
            res.MaxStakeAmount = e.max_stake;
            res.MinStakeAmount = e.min_stake;
            res.IncomePercentage = e.income_percentage;
            res.NotifyAdminOfPairedUsers = e.notify_admin;
            res.GetHelpLabel = e.get_help_label ?? "GET HELP";
            res.ProvideHelpLabel = e.provide_help_label ?? "PROVIDE HELP";
            res.TransactionLabel = e.transaction_label ?? "Transaction Centre";
            res.StakeMultiple = e.stake_multiple ?? 0;
            res.SendSms =e.send_sms ;
            res.SendEmail= e.send_email ;
            res.DefaultBannerUrl = e.default_banner_url;
            res.Tag1 =e.tag1 ;
            res.Tag2 =e.tag2 ;
            res.Tag3 =e.tag3 ;
            res.Tag4 =e.tag4 ;
            res.SupportBitcoin = e.support_bitcoin ?? false;
            res.CompanyInterestRate = e.company_interest_rate ?? 2.0m;
            res.UseMultipleProvideHelp = e.use_multiple_provide_help ?? false;
            res.UseMinMaxStakeAsFixed = e.use_min_max_stake_as_fixed_value ?? false;
            res.MultipleProvideHelpQueueLimit = e.multiple_provide_help_queue_limit ?? 3;
            res.CashAmountRange =e.cashAmtRange ;
            res.UseAmountRange =e.useAmtRange ;  
            res.BitcoinAmountRange=e.bitCoinAmtRange ;
            res.AutoGenerateGetHelpTicketForDefaulterParty =e.auto_generate_gh_ticket_for_defaulters_party  ?? true;
            res.RefererPay =  e.referer_pay?? 2000;
           res.RefererPayOffThreshold  =e.referer_payoff_threashold  ?? 30000;
           res.BitcoinIncomePercentage  =e.bitcoin_interest ?? 30m;
           res.BitcoinMinStakeAmount = e.btc_min_amt  ?? 0.1m;
            res.BitcoinMaxStakeAmount =e.btc_max_amount  ?? 5m;
            res.BitcoinSymbol  =e.btc_symbol ?? "BTC";
            res.UseMultipleAccountForAuthorization =e.required_multiple_account_for_authorization  ?? false;
           res.IncomeArePaidDuration = e.only_receive_income_when_day_elapses  ?? false;
            return res;
        }

        public override IEnumerable<OrgAppSetting> Get(Criteria criteria)
        {
            List<OrgAppSetting> res =  new List<OrgAppSetting>();
            if (criteria != null && string.IsNullOrEmpty(criteria.Id))
            {
                //assume id is Org info
                var data = db.org_global_settings.Where(x => x.org_id == criteria.Id);
                if (data != null)
                {
                    foreach (var s in data)
                    {
                        res.Add(fromEntity(s));
                    }
                }
            }
            return res;
        }
    }
}
