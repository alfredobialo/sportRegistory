namespace asom.apps.inOut.core.dal.sqlserver.db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class identity_store
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public identity_store()
        {
            identity_store_preference = new HashSet<identity_store_preference>();
        }

        [Key]
        [StringLength(50)]
        public string user_id { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        [StringLength(50)]
        public string org_id { get; set; }

        [StringLength(50)]
        public string channel_id { get; set; }

        public bool? is_active { get; set; }

        public bool? is_blocked { get; set; }

        [StringLength(50)]
        public string activation_code { get; set; }

        public DateTime? date_created { get; set; }

        [StringLength(70)]
        public string security_question { get; set; }

        [StringLength(50)]
        public string security_answer { get; set; }

        [StringLength(50)]
        public string phone_number { get; set; }

        [StringLength(70)]
        public string email_address { get; set; }

        [StringLength(70)]
        public string display_name { get; set; }

        [StringLength(350)]
        public string picture_url { get; set; }

        [StringLength(50)]
        public string obj_type { get; set; }

        [StringLength(50)]
        public string created_by { get; set; }

        [StringLength(10)]
        public string gender { get; set; }

        public DateTime? date_of_birth { get; set; }

        [StringLength(550)]
        public string signature_url { get; set; }

        public DateTime? activate_expiresOn { get; set; }

        [StringLength(90)]
        public string location { get; set; }

        [StringLength(50)]
        public string state { get; set; }

        [StringLength(50)]
        public string seriol_no { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<identity_store_preference> identity_store_preference { get; set; }
    }
}
