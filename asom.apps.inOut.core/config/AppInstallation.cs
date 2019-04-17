using System;
using System.Data;
using System.Data.SqlClient;

namespace asom.apps.inOut.core.config
{
    public class AppInstallation
    {
//        public static void InstallDatabaseOnce(string connectionStringName)
//        {
//            CreateDatabaseIfNotExists<EffectivDataModel> installDb  =  new CreateDatabaseIfNotExists<EffectivDataModel>();
//            installDb.InitializeDatabase(new EffectivDataModel(connectionStringName));
//
//        }
//        public static void InstallDatabaseOnce()
//        {
//            CreateDatabaseIfNotExists<EffectivDataModel> installDb  =  new CreateDatabaseIfNotExists<EffectivDataModel>();
//            installDb.InitializeDatabase(new EffectivDataModel());
//
//        }


        public static bool PatchDatabase(string dbConnectionString)
        {
            bool success = false;

            string script = @"
          
";
            if (!string.IsNullOrEmpty(dbConnectionString))
            {
                SqlConnection con = new SqlConnection(dbConnectionString);
                // Create a new Raw DB Connection
                try
                {
                    // Try open the Connection
                    con.Open();
                   

                    //execute a command
                    SqlCommand cmd = new SqlCommand(script, con);
                    cmd.ExecuteNonQuery();
                    success = true;
                }
                catch (SqlException err)
                {
                    success = false;
                }
                catch (Exception err)
                {
                    success = false;
                }

                finally
                {
                    
                        con.Close();
                 
                }
            }




            return success; 

        }

        public static string GetDatabaseScript( string  databaseName)
        {

            string useDb = $"USE {databaseName} ;"  , 
                readWriteDb  = $"ALTER DATABASE [{databaseName}] SET  READ_WRITE ; ";

            string script =useDb + @"


CREATE TABLE [dbo].[identity_store](
	[user_id] [varchar](50) NOT NULL,
	[password] [varchar](50) NULL,
	[org_id] [varchar](50) NULL,
	[channel_id] [varchar](50) NULL,
	[is_active] [bit] NULL,
	[is_blocked] [bit] NULL,
	[activation_code] [varchar](50) NULL,
	[date_created] [datetime] NULL,
	[security_question] [varchar](70) NULL,
	[security_answer] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[email_address] [varchar](70) NULL,
	[display_name] [nvarchar](70) NULL,
	[picture_url] [varchar](350) NULL,
	[obj_type] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
	[gender] [varchar](10) NULL,
	[date_of_birth] [datetime] NULL,
	[signature_url] [varchar](550) NULL,
	[activate_expiresOn] [datetime] NULL,
	[location] [nvarchar](90) NULL,
	[state] [nvarchar](50) NULL,
	[seriol_no] [varchar](50) NULL,
 CONSTRAINT [PK_dbo.identity_store] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[identity_store_audit_trail](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NULL,
	[date_logged_in] [datetime] NULL,
	[ip_address] [varchar](150) NULL,
	[user_agent] [nvarchar](350) NULL,
	[success] [bit] NULL,
 CONSTRAINT [PK_dbo.identity_store_audit_trail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[identity_store_preference](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[pref_key] [varchar](50) NULL,
	[pref_value] [varchar](max) NULL,
	[data_type] [varchar](50) NULL,
 CONSTRAINT [PK_dbo.identity_store_preference] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[itrex_auth_objectAccessAudit](
	[id] [nvarchar](50) NOT NULL,
	[roleUsed] [nvarchar](50) NULL,
	[PermissionsUsed] [varchar](450) NULL,
	[UserContext] [nvarchar](50) NULL,
	[dateAccessed] [datetime] NULL,
	[ActionDescription] [varchar](350) NULL,
 CONSTRAINT [PK_dbo.itrex_auth_objectAccessAudit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[itrex_auth_roleDefinition](
	[roleName] [nvarchar](50) NOT NULL,
	[roleDescription] [nvarchar](350) NULL,
	[isActive] [bit] NULL,
	[IsExpirable] [bit] NULL,
	[DateCreated] [datetime] NULL,
	[ExipiresOn] [datetime] NULL,
	[IsSystemDefined] [bit] NULL,
	[isAdmin] [bit] NULL,
	[GroupName] [varchar](50) NULL,
 CONSTRAINT [PK_dbo.itrex_auth_roleDefinition] PRIMARY KEY CLUSTERED 
(
	[roleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
CREATE TABLE [dbo].[itrex_auth_rolePermission](
	[id] [nvarchar](50) NOT NULL,
	[roleName] [nvarchar](50) NULL,
	[permissionName] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
	[IsExpirable] [bit] NULL,
	[DateCreated] [datetime] NULL,
	[ExpiresOn] [datetime] NULL,
	[description] [nvarchar](550) NULL,
 CONSTRAINT [PK_dbo.itrex_auth_rolePermission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
CREATE TABLE [dbo].[itrex_auth_usersInRole](
	[id] [nvarchar](50) NOT NULL,
	[userId] [nvarchar](50) NULL,
	[roleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.itrex_auth_usersInRole] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[judgeScore](
	[id] [varchar](50) NOT NULL,
	[groupId] [varchar](50) NULL,
	[score] [decimal](4, 2) NULL,
	[performerId] [varchar](50) NULL,
	[judgeId] [varchar](50) NULL,
	[sportType] [varchar](50) NULL,
	[dateFilter] [datetime] NULL,
 CONSTRAINT [PK_judgeScore] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[org_business_channels](
	[id] [varchar](50) NOT NULL,
	[location] [nvarchar](50) NULL,
	[address] [nvarchar](350) NULL,
	[city] [nvarchar](30) NULL,
	[phoneNo] [varchar](100) NULL,
	[isActive] [bit] NULL,
	[isHeadOffice] [bit] NULL,
	[tag] [varchar](50) NULL,
	[org_id] [varchar](50) NULL,
	[extra_data1] [varchar](350) NULL,
	[extra_data2] [varchar](350) NULL,
	[extra_data3] [varchar](350) NULL,
	[extra_data4] [varchar](350) NULL,
 CONSTRAINT [PK_dbo.org_business_channels] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[org_company_profile](
	[id] [varchar](50) NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[slogan] [nvarchar](250) NULL,
	[lo ; Url] [varchar](550) NULL,
	[signatureUrl] [varchar](550) NULL,
	[secondaryLo ; Url] [varchar](550) NULL,
	[lo ; Blob] [varbinary](max) NULL,
	[signatureBlob] [varbinary](max) NULL,
	[dateCreated] [datetime] NULL,
	[note] [nvarchar](max) NULL,
	[email] [varchar](50) NULL,
	[website] [varchar](100) NULL,
	[aboutCompany] [nvarchar](max) NULL,
	[faq] [nvarchar](max) NULL,
	[extra1] [nvarchar](max) NULL,
	[extra2] [nvarchar](max) NULL,
	[extra3] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.org_company_profile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[org_global_settings](
	[id] [varchar](50) NOT NULL,
	[org_id] [varchar](50) NULL,
	[block_failed_user_login_attempt] [bit] NULL,
	[allowed_login_attempt] [tinyint] NULL,
	[application_theme] [varchar](150) NULL,
	[currency_symbol] [nvarchar](4) NULL,
	[currency_name] [nvarchar](20) NULL,
	[currency_name_abbrv] [nvarchar](5) NULL,
	[isActive] [bit] NULL,
	[acc_show_inactive_account] [bit] NULL,
	[smpt_port] [varchar](50) NULL,
	[smpt_server_address] [varchar](2000) NULL,
	[smpt_user_id] [varchar](50) NULL,
	[smtp_password] [varchar](50) NULL,
	[sms_gateway_address] [varchar](2000) NULL,
	[sms_gateway_user_id] [varchar](50) NULL,
	[sms_gateway_password] [varchar](50) NULL,
	[customer_label] [nvarchar](40) NULL,
	[always_block_defaulters] [bit] NULL,
	[grace_days_to_pay] [int] NULL,
	[income_percentage] [decimal](9, 2) NULL,
	[income_maturity_days] [int] NULL,
	[auto_pair_payers] [bit] NULL,
	[notify_admin] [bit] NULL,
	[use_access_pin_for_registration] [bit] NULL,
	[block_registration] [bit] NULL,
	[min_stake] [decimal](18, 2) NULL,
	[max_stake] [decimal](18, 2) NULL,
	[stake_multiple] [decimal](18, 2) NULL,
	[get_help_label] [nvarchar](50) NULL,
	[provide_help_label] [nvarchar](50) NULL,
	[transaction_label] [nvarchar](50) NULL,
	[send_sms] [bit] NULL,
	[send_email] [bit] NULL,
	[default_banner_url] [varchar](1000) NULL,
	[tag1] [varchar](200) NULL,
	[tag2] [varchar](200) NULL,
	[tag3] [varchar](200) NULL,
	[tag4] [varchar](200) NULL,
	[support_bitcoin] [bit] NULL,
	[company_interest_rate] [decimal](7, 2) NULL,
	[use_multiple_provide_help] [bit] NULL,
	[multiple_provide_help_queue_limit] [int] NULL,
	[use_min_max_stake_as_fixed_value] [bit] NULL,
	[auto_pair_minute_interval] [int] NULL,
	[bitCoinAmtRange] [varchar](1050) NULL,
	[cashAmtRange] [varchar](1050) NULL,
	[useAmtRange] [bit] NULL,
	[only_receive_income_when_day_elapses] [bit] NULL,
	[bitcoin_interest] [decimal](9, 2) NULL,
	[referer_pay] [decimal](18, 2) NULL,
	[referer_payoff_threashold] [decimal](18, 2) NULL,
	[required_multiple_account_for_authorization] [bit] NULL,
	[btc_symbol] [varchar](5) NULL,
	[btc_min_amt] [decimal](18, 2) NULL,
	[btc_max_amount] [decimal](18, 2) NULL,
	[btc_stake_multiple] [decimal](9, 2) NULL,
	[auto_generate_gh_ticket_for_defaulters_party] [bit] NULL,
 CONSTRAINT [PK_dbo.org_global_settings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[org_media_store](
	[id] [varchar](50) NOT NULL,
	[media_type] [varchar](50) NULL,
	[media_file_url] [varchar](1050) NULL,
	[media_tag] [varchar](150) NULL,
	[is_active] [bit] NULL,
	[media_owner_id] [varchar](50) NULL,
	[media_owner_group] [varchar](50) NULL,
	[date_created] [datetime] NULL,
 CONSTRAINT [PK_dbo.org_media_store] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
SET ANSI_NULLS ON
 ; 
SET QUOTED_IDENTIFIER ON
 ; 
SET ANSI_PADDING ON
 ; 
CREATE TABLE [dbo].[performer_user](
	[id] [varchar](50) NOT NULL,
	[firstName] [nvarchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[age] [tinyint] NULL,
	[nationality] [nvarchar](50) NULL,
 CONSTRAINT [PK_performer_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

 ; 
SET ANSI_PADDING OFF
 ; 
ALTER TABLE [dbo].[identity_store_preference]  WITH CHECK ADD  CONSTRAINT [FK_dbo.identity_store_preference_dbo.identity_store_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[identity_store] ([user_id])
ON DELETE CASCADE
 ; 
ALTER TABLE [dbo].[identity_store_preference] CHECK CONSTRAINT [FK_dbo.identity_store_preference_dbo.identity_store_user_id]
 ; 
ALTER TABLE [dbo].[itrex_auth_objectAccessAudit]  WITH CHECK ADD  CONSTRAINT [FK_dbo.itrex_auth_objectAccessAudit_dbo.itrex_auth_roleDefinition_roleUsed] FOREIGN KEY([roleUsed])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON DELETE CASCADE
 ; 
ALTER TABLE [dbo].[itrex_auth_objectAccessAudit] CHECK CONSTRAINT [FK_dbo.itrex_auth_objectAccessAudit_dbo.itrex_auth_roleDefinition_roleUsed]
 ; 
ALTER TABLE [dbo].[itrex_auth_rolePermission]  WITH CHECK ADD  CONSTRAINT [FK_dbo.itrex_auth_rolePermission_dbo.itrex_auth_roleDefinition_roleName] FOREIGN KEY([roleName])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON DELETE CASCADE
 ; 
ALTER TABLE [dbo].[itrex_auth_rolePermission] CHECK CONSTRAINT [FK_dbo.itrex_auth_rolePermission_dbo.itrex_auth_roleDefinition_roleName]
 ; 
ALTER TABLE [dbo].[itrex_auth_usersInRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.itrex_auth_usersInRole_dbo.itrex_auth_roleDefinition_roleName] FOREIGN KEY([roleName])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON DELETE CASCADE
 ; 
ALTER TABLE [dbo].[itrex_auth_usersInRole] CHECK CONSTRAINT [FK_dbo.itrex_auth_usersInRole_dbo.itrex_auth_roleDefinition_roleName]
 ; 
ALTER TABLE [dbo].[org_business_channels]  WITH CHECK ADD  CONSTRAINT [FK_dbo.org_business_channels_dbo.org_company_profile_org_id] FOREIGN KEY([org_id])
REFERENCES [dbo].[org_company_profile] ([id])
ON DELETE CASCADE
 ; 
ALTER TABLE [dbo].[org_business_channels] CHECK CONSTRAINT [FK_dbo.org_business_channels_dbo.org_company_profile_org_id]
 ; 









" + readWriteDb;
            return script;
        }

        public static bool PingDbServer(string appConnectionString)
        {
            SqlConnection con =  new SqlConnection(appConnectionString);
            bool success = false;
            try
            {
                con.Open();
                success = true;
            }
            catch (SqlException err)
            {

            }
            finally
            {
                if (con.State == ConnectionState.Open || con.State == ConnectionState.Connecting)
                {
                    con.Close();
                }
            }
            return success;
        }
    }
}
