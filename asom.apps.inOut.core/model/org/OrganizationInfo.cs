using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using asom.apps.inOut.core.dal.sqlserver.model;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model.org
{
    public class OrganizationInfo  :DefaultPersistable<OrganizationInfo>
    {
        public const string ORG_CODE = "InOut-HQ";
        public const string ORG_SETTING_CODE = "InOut-HqSettings";
        public OrganizationInfo()
        {
            //Always ensure current user is authenticated
//            checkCurrentUser = true;
            Key = ORG_CODE;
            ChannelInfo.Key = ORG_CODE;
            ChannelInfo.IsHeadOffice = true;
            Slogan = "Your Slogan";
          AboutTheCompany = "About The Company Goes here";
        }

        // Only Allow one Instance of this Object
        public string Name { get; set; } = "Your Company Name";//
        public string Slogan { get; set; }
        public string  LogoUrl { get; set; }
        public string  Website { get; set; }
        public string  Email { get; set; }
        public string SignatureUrl { get; set; }
        public string SecondaryLogoUrl { get; set; }
        public string Note { get; set; }
        public byte[] LogoBlob { get; set; }
        public byte[] SignatureBlob { get; set; }


        public string  AboutTheCompany { get; set; }
        BusinessChannel cnnInfo =  new BusinessChannel();
        public BusinessChannel ChannelInfo
        {
            get { return cnnInfo; }
            internal set
            {
                cnnInfo = value;
                cnnInfo.Key = ORG_CODE;
            }
        }

      public string Faq { get; set; }=  "";
      public string Extra1 { get; set; }=  "";
      public string Extra2 { get; set; }=  "";
      public string Extra3 { get; set; }=  "";

      public override DefRepository<OrganizationInfo> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<OrganizationInfo>.DataSource ?? new OrgRepo();
        }

        public static OrgAppSetting GetSettings()
        {
            OrgAppSetting os = OrgAppSetting.Get();
            os.Key = ORG_SETTING_CODE;
            return os;

        }


        public void SaveRecord()
        {

             SaveSelf(this,true);
             ChannelInfo.OrgInfo = this;
             ChannelInfo.Save(true);
        }
        public Task SaveRecordAsync()
        {

           return  SaveSelfAsync(this,true);
        }

        public static OrganizationInfo Get()
        {
            return new OrganizationInfo().Find(ORG_CODE);
        }

        public static Task<OrganizationInfo> GetAsync()
        {
            return new OrganizationInfo().FindAsync(ORG_CODE);
        }

        public static bool IsProfileCreated()
        {
            return new OrganizationInfo().Exist();
        }

        public static bool IsOrgProfileSet()
        {
            return new OrganizationInfo().Exist();
        }

        internal bool Exist()
        {
            this.Key = ORG_CODE;
            return IsFound(this);
        }

        public  BusinessChannel CreateBusinessChannel(string code)
        {
            BusinessChannel res  = new BusinessChannel
            {
                OrgInfo =  this,
                Key = code,
                IsOn = true,
                IsHeadOffice =  false
            };
            return res;
        }

        public IEnumerable<BusinessChannel> GetBusinessChannels()
        {
            return BusinessChannel.Get(new Criteria() {Id = Key, Tag = this});
        }

     }

    public class OrganizationInfoNotSetException : ApplicationException
    {
        public OrganizationInfoNotSetException(string message):base(message)
        {


        }

        public OrganizationInfoNotSetException() : this("Organization Profile Not yet set")
        {

        }
    }

    public interface IOrgInfo
    {
        string Key { get; set; }
        string Name { get; set; }
        string Slogan { get; set; }
        string  LogoUrl { get; set; }
    }
}
