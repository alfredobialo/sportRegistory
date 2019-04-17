namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("judgeScore")]
    public partial class judgeScore
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string groupId { get; set; }

        public decimal? score { get; set; }

        [StringLength(50)]
        public string performerId { get; set; }

        [StringLength(50)]
        public string judgeId { get; set; }

        [StringLength(50)]
        public string sportType { get; set; }

        public DateTime? dateFilter { get; set; }
    }
}
