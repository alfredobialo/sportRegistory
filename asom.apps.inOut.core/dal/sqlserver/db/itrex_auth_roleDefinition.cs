namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class itrex_auth_roleDefinition
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public itrex_auth_roleDefinition()
        {
            itrex_auth_objectAccessAudit = new HashSet<itrex_auth_objectAccessAudit>();
            itrex_auth_rolePermission = new HashSet<itrex_auth_rolePermission>();
            itrex_auth_usersInRole = new HashSet<itrex_auth_usersInRole>();
        }

        [Key]
        [StringLength(50)]
        public string roleName { get; set; }

        [StringLength(350)]
        public string roleDescription { get; set; }

        public bool? isActive { get; set; }

        public bool? IsExpirable { get; set; }

        public DateTime? DateCreated { get; set; }

        public DateTime? ExipiresOn { get; set; }

        public bool? IsSystemDefined { get; set; }

        public bool? isAdmin { get; set; }

        [StringLength(50)]
        public string GroupName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<itrex_auth_objectAccessAudit> itrex_auth_objectAccessAudit { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<itrex_auth_rolePermission> itrex_auth_rolePermission { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<itrex_auth_usersInRole> itrex_auth_usersInRole { get; set; }
    }
}
