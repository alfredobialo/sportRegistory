namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class org_business_channels
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string location { get; set; }

        [StringLength(350)]
        public string address { get; set; }

        [StringLength(30)]
        public string city { get; set; }

        [StringLength(100)]
        public string phoneNo { get; set; }

        public bool? isActive { get; set; }

        public bool? isHeadOffice { get; set; }

        [StringLength(50)]
        public string tag { get; set; }

        [StringLength(50)]
        public string org_id { get; set; }

        [StringLength(350)]
        public string extra_data1 { get; set; }

        [StringLength(350)]
        public string extra_data2 { get; set; }

        [StringLength(350)]
        public string extra_data3 { get; set; }

        [StringLength(350)]
        public string extra_data4 { get; set; }

        public virtual org_company_profile org_company_profile { get; set; }
    }
}
