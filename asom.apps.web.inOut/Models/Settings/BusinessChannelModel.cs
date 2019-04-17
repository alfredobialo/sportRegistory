using System;
using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.model.org;

namespace asom.apps.web.inOut.Models.Settings
{
    [Serializable]
    public class BusinessChannelModel  :BaseModel
    {

        public IEnumerable<BusinessChannelModel> GetBusinessChannelModels()
        {
            return new List<BusinessChannelModel>();
        }
        public string Location { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string PhoneNumber { get; set; }
        public string Tag { get; set; }
        public string ExtraData1 { get; set; }
        public string ExtraData2 { get; set; }
        public string ExtraData3 { get; set; }
        public string ExtraData4 { get; set; }
        public bool? IsHeadOffice { get; internal set; } = false;

        public static implicit operator BusinessChannelModel(BusinessChannel o)
        {
            BusinessChannelModel res = new BusinessChannelModel();
            res.Tag = o.Tag;
            res.Address = o.Address;
            res.City = o.City;
            res.ExtraData1 = o.ExtraData1;
            res.ExtraData2 = o.ExtraData2;
            res.ExtraData3 = o.ExtraData3;
            res.ExtraData4 = o.ExtraData4;
            res.IsHeadOffice = o.IsHeadOffice;
            res.Location = o.Location;
            
            res.PhoneNumber = o.PhoneNumber;
            res.Id = o.Key;
            
            return res;
        }

        public static ServerResponseModel GetChannels()
        {
            var data  = OrganizationInfo.Get().GetBusinessChannels().Select(x => (BusinessChannelModel)x);
            ServerResponseModel res = new ServerResponseModel()
            {
                Success = true,
                Message =  "Business Channels Fetched!",
                Data  = data
            };
            return res;
        }
        public static ServerResponseModel GetChannel(string channelCode)
        {
            BusinessChannelModel data  = BusinessChannel.Get(channelCode);//.OrganizationInfo.Get().GetBusinessChannels().Select(x => (BusinessChannelModel)x));
            ServerResponseModel res = new ServerResponseModel()
            {
                Success = true,
                Message =  "Business Channel Fetched!",
                Data  = data
            };
            return res;
        } 

//        public string Id { get; set; }
    }
}