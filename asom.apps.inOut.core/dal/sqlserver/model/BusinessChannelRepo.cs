using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal.sqlserver.model
{
    public class BusinessChannelRepo  : SqlServerDal<BusinessChannel>
    {
        protected internal BusinessChannelRepo()
        {
            
        }

        public override void Save(BusinessChannel obj)
        {
            //TODO : Fix the business channel Section
            org_business_channels e = toEntity(obj);
            db.org_business_channels.Add(e);
            Save();
        }

        public override bool IsFound(BusinessChannel obj)
        {
            return db.org_business_channels.Any(x => x.id == obj.Key);

        }

        public override IEnumerable<BusinessChannel> Get(Criteria criteria)
        {
            List<BusinessChannel > res  =  new List<BusinessChannel>();
            if (criteria != null)
            {
                var data = db.org_business_channels
                    .Where(x => x.org_id == criteria.Id && x.isHeadOffice == false);
                foreach (var a in data)
                {
                    res.Add(fromEntity(a));
                }

            }
            return res;
        }

        public override BusinessChannel Get(object id)
        {
            BusinessChannel res =  new BusinessChannel() {Id = id};
            var data = db.org_business_channels.FirstOrDefault(x => x.id == res.Key);
            if (data != null)
            {
                res = fromEntity(data);
            }
            else
            {
                res = null;

            }
            return res;
        }

        public override void Update(BusinessChannel obj)
        {
            var data = db.org_business_channels
                    .FirstOrDefault(x => x.id == obj.Key );
            if (data != null)
            {
                toEntity(data,obj);
                Save();
            }
           
        }

        public override void Delete(BusinessChannel obj)
        {
            var data = db.org_business_channels
                    .FirstOrDefault(x => x.id == obj.Key && x.isHeadOffice == false);
            if (data != null)
            {
                db.org_business_channels.Remove(data);
                Save();
            }
        }

        private org_business_channels toEntity(BusinessChannel o)
        {
            return toEntity(new org_business_channels(), o);
        }

        private org_business_channels toEntity(org_business_channels e, BusinessChannel o)
        {
            e.id = o.Key;
            e.address = o.Address;
            e.city = o.City;
            e.extra_data1 = o.ExtraData1;
            e.extra_data2 = o.ExtraData2;
            e.extra_data3 = o.ExtraData3;
            e.extra_data4 = o.ExtraData4;
            e.isActive = o.IsOn;
            e.isHeadOffice = o.IsHeadOffice;
            e.location = o.Location;
            e.org_id = o.OrgInfo.Key;
            e.city = o.City;
            e.phoneNo = o.PhoneNumber;
            e.tag = o.Tag;
            
            return e;
        }

        BusinessChannel fromEntity(org_business_channels e)
        {
            BusinessChannel res  =  new BusinessChannel();
            res.Key = e.id;
            res.City = e.city;
            res.IsHeadOffice = e.isHeadOffice;
            res.IsOn = e.isActive;
            res.Location = e.location;
            res.PhoneNumber = e.phoneNo;
           
            res.PhoneNumber = e.phoneNo;
            res.Tag = e.tag;
            res.Address = e.address;
            res.ExtraData1 = e.extra_data1;
            res.ExtraData2 = e.extra_data2;
            res.ExtraData3 = e.extra_data3;
            res.ExtraData4 = e.extra_data4;
            //res.OrgInfo = OrganizationInfo.Get();
            
            return res;
        }
    }
}
