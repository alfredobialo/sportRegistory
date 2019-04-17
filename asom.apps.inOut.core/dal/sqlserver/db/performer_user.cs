namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class performer_user
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string firstName { get; set; }

        [StringLength(50)]
        public string lastName { get; set; }

        public byte? age { get; set; }

        [StringLength(50)]
        public string nationality { get; set; }
    }
}
