namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class identity_store_preference
    {
        [StringLength(50)]
        public string id { get; set; }

        [Required]
        [StringLength(50)]
        public string user_id { get; set; }

        [StringLength(50)]
        public string pref_key { get; set; }

        public string pref_value { get; set; }

        [StringLength(50)]
        public string data_type { get; set; }

        public virtual identity_store identity_store { get; set; }
    }
}
