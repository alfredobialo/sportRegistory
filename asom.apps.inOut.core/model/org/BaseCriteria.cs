using System;
using itrex.businessObjects.model.core.pager;

namespace asom.apps.inOut.core.model.org
{

    public class BaseCriteria : DataPagerCriteria
    {
        public BaseCriteria()
        {
//            ActiveValue = true;
        }
        public string ChannelId { get; set; }
        public bool FindByChannelId { get; set; }
        public string OrgId { get; internal set; } = OrganizationInfo.ORG_CODE;
       public bool GetActive { get; set; }
        public bool ActiveValue { get; set; }
        public bool SearchByDateRange { get; set; }
        public bool ForReport { get; set; }
        public string ReportCheckTag { get; set; }

    }


    public interface IAccountPeriod
    {
        DateTime StartDate { get; set; }
        DateTime EndDate { get; set; }
        string ChannelId { get; set; }  //  Could

    }
}
