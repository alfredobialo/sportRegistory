using System.Collections.Generic;
using System.Threading.Tasks;
using asom.apps.inOut.core.dal.sqlserver.model;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model.org
{
/*
    Business Channel account cannot be deleted if created, but can be made in-active
    , its field can be changed,
    when a Business channel is blocked, users on that channel cannot login

*/

    public class BusinessChannel  : DefaultPersistable<BusinessChannel>, IBizChannel
    {
        internal BusinessChannel()
        {
            
        }
        public string Location { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string PhoneNumber { get; set; }
        public string Tag { get; set; }
        public OrganizationInfo OrgInfo { get; internal set; }
        public string ExtraData1 { get; set; }
        public string ExtraData2 { get; set; }
        public string ExtraData3 { get; set; }
        public string ExtraData4 { get; set; }
        public bool? IsHeadOffice { get; internal set; } = false;
        public override DefRepository<BusinessChannel> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<BusinessChannel>.DataSource ?? new BusinessChannelRepo();
        }

        public static BusinessChannel GetDefault()
        {
            return BusinessChannel.Get(OrganizationInfo.ORG_CODE);
        }

        public bool Exist()
        {
            return IsFound(this);
        }
        public void Save()
        {
            SaveSelf(this);
        }
        public void Save(bool updateIfFound)
        {
            SaveSelf(this, updateIfFound);
        }
        public Task SaveAsync()
        {
            return SaveSelfAsync(this);
        }
        public Task SaveAsync(bool updateIfFound)
        {
            return SaveSelfAsync(this, updateIfFound);
        }
        public static BusinessChannel Get(string id)
        {
            return new BusinessChannel().Find(id);
        }
        public static IEnumerable<BusinessChannel> Get(Criteria criteria)
        {
            return new BusinessChannel().Find(criteria);
        }
        public static Task<BusinessChannel> GetAsync(string id)
        {
            return new BusinessChannel().FindAsync(id);
        }
        public static Task<IEnumerable<BusinessChannel>> GetAsync(Criteria criteria)
        {
            return new BusinessChannel().FindAsync(criteria);
        }

    }

    public interface IBizChannel
    {
        string Key { get; set; }
    }

    public class DefaultBizChannel : IBizChannel
    {
        public DefaultBizChannel()
        {
            AppConfig config = AppConfig.GetInstance();
            if (config.CurrentUser != null)
            {
                Key = config.CurrentUser.ChannelId;
            }
            else
            {
                Key = OrganizationInfo.ORG_CODE;
            }
        }
        public string Key { get; set; }
    }

}
