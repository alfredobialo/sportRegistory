namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class itrex_auth_objectAccessAudit
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string roleUsed { get; set; }

        [StringLength(450)]
        public string PermissionsUsed { get; set; }

        [StringLength(50)]
        public string UserContext { get; set; }

        public DateTime? dateAccessed { get; set; }

        [StringLength(350)]
        public string ActionDescription { get; set; }

        public virtual itrex_auth_roleDefinition itrex_auth_roleDefinition { get; set; }
    }
}
