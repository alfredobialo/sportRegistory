namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class org_global_settings
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string org_id { get; set; }

        public bool? block_failed_user_login_attempt { get; set; }

        public byte? allowed_login_attempt { get; set; }

        [StringLength(150)]
        public string application_theme { get; set; }

        [StringLength(4)]
        public string currency_symbol { get; set; }

        [StringLength(20)]
        public string currency_name { get; set; }

        [StringLength(5)]
        public string currency_name_abbrv { get; set; }

        public bool? isActive { get; set; }

        public bool? acc_show_inactive_account { get; set; }

        [StringLength(50)]
        public string smpt_port { get; set; }

        [StringLength(2000)]
        public string smpt_server_address { get; set; }

        [StringLength(50)]
        public string smpt_user_id { get; set; }

        [StringLength(50)]
        public string smtp_password { get; set; }

        [StringLength(2000)]
        public string sms_gateway_address { get; set; }

        [StringLength(50)]
        public string sms_gateway_user_id { get; set; }

        [StringLength(50)]
        public string sms_gateway_password { get; set; }

        [StringLength(40)]
        public string customer_label { get; set; }

        public bool? always_block_defaulters { get; set; }

        public int? grace_days_to_pay { get; set; }

        public decimal? income_percentage { get; set; }

        public int? income_maturity_days { get; set; }

        public bool? auto_pair_payers { get; set; }

        public bool? notify_admin { get; set; }

        public bool? use_access_pin_for_registration { get; set; }

        public bool? block_registration { get; set; }

        public decimal? min_stake { get; set; }

        public decimal? max_stake { get; set; }

        public decimal? stake_multiple { get; set; }

        [StringLength(50)]
        public string get_help_label { get; set; }

        [StringLength(50)]
        public string provide_help_label { get; set; }

        [StringLength(50)]
        public string transaction_label { get; set; }

        public bool? send_sms { get; set; }

        public bool? send_email { get; set; }

        [StringLength(1000)]
        public string default_banner_url { get; set; }

        [StringLength(200)]
        public string tag1 { get; set; }

        [StringLength(200)]
        public string tag2 { get; set; }

        [StringLength(200)]
        public string tag3 { get; set; }

        [StringLength(200)]
        public string tag4 { get; set; }

        public bool? support_bitcoin { get; set; }

        public decimal? company_interest_rate { get; set; }

        public bool? use_multiple_provide_help { get; set; }

        public int? multiple_provide_help_queue_limit { get; set; }

        public bool? use_min_max_stake_as_fixed_value { get; set; }

        public int? auto_pair_minute_interval { get; set; }

        [StringLength(1050)]
        public string bitCoinAmtRange { get; set; }

        [StringLength(1050)]
        public string cashAmtRange { get; set; }

        public bool? useAmtRange { get; set; }

        public bool? only_receive_income_when_day_elapses { get; set; }

        public decimal? bitcoin_interest { get; set; }

        public decimal? referer_pay { get; set; }

        public decimal? referer_payoff_threashold { get; set; }

        public bool? required_multiple_account_for_authorization { get; set; }

        [StringLength(5)]
        public string btc_symbol { get; set; }

        public decimal? btc_min_amt { get; set; }

        public decimal? btc_max_amount { get; set; }

        public decimal? btc_stake_multiple { get; set; }

        public bool? auto_generate_gh_ticket_for_defaulters_party { get; set; }
    }
}
