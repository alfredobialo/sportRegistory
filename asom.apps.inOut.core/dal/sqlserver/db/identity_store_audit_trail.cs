namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class identity_store_audit_trail
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string user_id { get; set; }

        public DateTime? date_logged_in { get; set; }

        [StringLength(150)]
        public string ip_address { get; set; }

        [StringLength(350)]
        public string user_agent { get; set; }

        public bool? success { get; set; }
    }
}
