namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class itrex_auth_rolePermission
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string roleName { get; set; }

        [StringLength(150)]
        public string permissionName { get; set; }

        public bool? IsActive { get; set; }

        public bool? IsExpirable { get; set; }

        public DateTime? DateCreated { get; set; }

        public DateTime? ExpiresOn { get; set; }

        [StringLength(550)]
        public string description { get; set; }

        public virtual itrex_auth_roleDefinition itrex_auth_roleDefinition { get; set; }
    }
}
