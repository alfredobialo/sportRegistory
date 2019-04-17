namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class sports_db : DbContext
    {
        public sports_db()
            : base("name=sports_db")
        {
        }

        public virtual DbSet<identity_store> identity_store { get; set; }
        public virtual DbSet<identity_store_audit_trail> identity_store_audit_trail { get; set; }
        public virtual DbSet<identity_store_preference> identity_store_preference { get; set; }
        public virtual DbSet<itrex_auth_objectAccessAudit> itrex_auth_objectAccessAudit { get; set; }
        public virtual DbSet<itrex_auth_roleDefinition> itrex_auth_roleDefinition { get; set; }
        public virtual DbSet<itrex_auth_rolePermission> itrex_auth_rolePermission { get; set; }
        public virtual DbSet<itrex_auth_usersInRole> itrex_auth_usersInRole { get; set; }
        public virtual DbSet<judgeScore> judgeScore { get; set; }
        public virtual DbSet<org_business_channels> org_business_channels { get; set; }
        public virtual DbSet<org_company_profile> org_company_profile { get; set; }
        public virtual DbSet<org_global_settings> org_global_settings { get; set; }
        public virtual DbSet<org_media_store> org_media_store { get; set; }
        public virtual DbSet<performer_user> performer_user { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<identity_store>()
                .Property(e => e.user_id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.password)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.org_id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.channel_id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.activation_code)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.security_question)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.security_answer)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.phone_number)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.email_address)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.picture_url)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.obj_type)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.created_by)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.gender)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.signature_url)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store>()
                .Property(e => e.seriol_no)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_audit_trail>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_audit_trail>()
                .Property(e => e.user_id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_audit_trail>()
                .Property(e => e.ip_address)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_preference>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_preference>()
                .Property(e => e.user_id)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_preference>()
                .Property(e => e.pref_key)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_preference>()
                .Property(e => e.pref_value)
                .IsUnicode(false);

            modelBuilder.Entity<identity_store_preference>()
                .Property(e => e.data_type)
                .IsUnicode(false);

            modelBuilder.Entity<itrex_auth_objectAccessAudit>()
                .Property(e => e.PermissionsUsed)
                .IsUnicode(false);

            modelBuilder.Entity<itrex_auth_objectAccessAudit>()
                .Property(e => e.ActionDescription)
                .IsUnicode(false);

            modelBuilder.Entity<itrex_auth_roleDefinition>()
                .Property(e => e.GroupName)
                .IsUnicode(false);

            modelBuilder.Entity<itrex_auth_roleDefinition>()
                .HasMany(e => e.itrex_auth_objectAccessAudit)
                .WithOptional(e => e.itrex_auth_roleDefinition)
                .HasForeignKey(e => e.roleUsed)
                .WillCascadeOnDelete();

            modelBuilder.Entity<itrex_auth_roleDefinition>()
                .HasMany(e => e.itrex_auth_rolePermission)
                .WithOptional(e => e.itrex_auth_roleDefinition)
                .WillCascadeOnDelete();

            modelBuilder.Entity<itrex_auth_roleDefinition>()
                .HasMany(e => e.itrex_auth_usersInRole)
                .WithOptional(e => e.itrex_auth_roleDefinition)
                .WillCascadeOnDelete();

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.groupId)
                .IsUnicode(false);

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.score)
                .HasPrecision(4, 2);

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.performerId)
                .IsUnicode(false);

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.judgeId)
                .IsUnicode(false);

            modelBuilder.Entity<judgeScore>()
                .Property(e => e.sportType)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.phoneNo)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.tag)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.org_id)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.extra_data1)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.extra_data2)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.extra_data3)
                .IsUnicode(false);

            modelBuilder.Entity<org_business_channels>()
                .Property(e => e.extra_data4)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.logoUrl)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.signatureUrl)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.secondaryLogoUrl)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.email)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .Property(e => e.website)
                .IsUnicode(false);

            modelBuilder.Entity<org_company_profile>()
                .HasMany(e => e.org_business_channels)
                .WithOptional(e => e.org_company_profile)
                .HasForeignKey(e => e.org_id)
                .WillCascadeOnDelete();

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.org_id)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.application_theme)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.smpt_port)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.smpt_server_address)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.smpt_user_id)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.smtp_password)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.sms_gateway_address)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.sms_gateway_user_id)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.sms_gateway_password)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.income_percentage)
                .HasPrecision(9, 2);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.default_banner_url)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.tag1)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.tag2)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.tag3)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.tag4)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.company_interest_rate)
                .HasPrecision(7, 2);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.bitCoinAmtRange)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.cashAmtRange)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.bitcoin_interest)
                .HasPrecision(9, 2);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.btc_symbol)
                .IsUnicode(false);

            modelBuilder.Entity<org_global_settings>()
                .Property(e => e.btc_stake_multiple)
                .HasPrecision(9, 2);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.media_type)
                .IsUnicode(false);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.media_file_url)
                .IsUnicode(false);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.media_tag)
                .IsUnicode(false);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.media_owner_id)
                .IsUnicode(false);

            modelBuilder.Entity<org_media_store>()
                .Property(e => e.media_owner_group)
                .IsUnicode(false);

            modelBuilder.Entity<performer_user>()
                .Property(e => e.id)
                .IsUnicode(false);
        }
    }
}
