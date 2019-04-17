namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class org_media_store
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string media_type { get; set; }

        [StringLength(1050)]
        public string media_file_url { get; set; }

        [StringLength(150)]
        public string media_tag { get; set; }

        public bool? is_active { get; set; }

        [StringLength(50)]
        public string media_owner_id { get; set; }

        [StringLength(50)]
        public string media_owner_group { get; set; }

        public DateTime? date_created { get; set; }
    }
}
