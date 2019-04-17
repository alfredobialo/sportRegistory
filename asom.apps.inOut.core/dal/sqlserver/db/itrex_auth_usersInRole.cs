namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class itrex_auth_usersInRole
    {
        [StringLength(50)]
        public string id { get; set; }

        [StringLength(50)]
        public string userId { get; set; }

        [StringLength(50)]
        public string roleName { get; set; }

        public virtual itrex_auth_roleDefinition itrex_auth_roleDefinition { get; set; }
    }
}
