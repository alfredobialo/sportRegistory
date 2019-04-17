namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class org_company_profile
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public org_company_profile()
        {
            org_business_channels = new HashSet<org_business_channels>();
        }

        [StringLength(50)]
        public string id { get; set; }

        [Required]
        [StringLength(250)]
        public string name { get; set; }

        [StringLength(250)]
        public string slogan { get; set; }

        [StringLength(550)]
        public string logoUrl { get; set; }

        [StringLength(550)]
        public string signatureUrl { get; set; }

        [StringLength(550)]
        public string secondaryLogoUrl { get; set; }

        public byte[] logoBlob { get; set; }

        public byte[] signatureBlob { get; set; }

        public DateTime? dateCreated { get; set; }

        public string note { get; set; }

        [StringLength(50)]
        public string email { get; set; }

        [StringLength(100)]
        public string website { get; set; }

        public string aboutCompany { get; set; }

        public string faq { get; set; }

        public string extra1 { get; set; }

        public string extra2 { get; set; }

        public string extra3 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<org_business_channels> org_business_channels { get; set; }
    }
}
