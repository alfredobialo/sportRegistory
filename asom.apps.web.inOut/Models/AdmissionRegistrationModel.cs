using System;
using System.ComponentModel.DataAnnotations;

namespace asom.apps.web.inOut.Models
{
    public class AdmissionRegistrationModel
    {
        [Required(ErrorMessage = "{0} Required")]
        [Display(Name = "First Name") , MaxLength(30, ErrorMessage = "Max Lenth Can't Exceed 30 Characters"),MinLength(1,ErrorMessage = "Minimum Length Error!")]
        public string  firstName { get; set; }

        [Required(ErrorMessage = "{0} Required")]
        [Display(Name = "Last Name"), MaxLength(30, ErrorMessage = "Max Lenth Can't Exceed 30 Characters"), MinLength(1, ErrorMessage = "Minimum Length Error!")]
        public string lastName { get; set; }
        [Required(ErrorMessage = "{0} Required")]
        [Display(Name = "Contact Address"), MaxLength(200, ErrorMessage = "Max Lenth Can't Exceed 30 Characters"), MinLength(1, ErrorMessage = "Minimum Length Error!")]
        public string contactAddress { get; set; }
        [Required(ErrorMessage = "{0} Required")]
        [Display(Name = "Contact Phone"), MaxLength(16, ErrorMessage = "Max Lenth Can't Exceed 30 Characters"), MinLength(11, ErrorMessage = "Minimum Length Error!")]
        public string contactPhone { get; set; }

        [Required(ErrorMessage = "{0} Required")]
        [Display(Name = "Parent/Gaurdian"), MaxLength(70, ErrorMessage = "Max Lenth Can't Exceed 30 Characters"), MinLength(5, ErrorMessage = "Minimum Length Error!")]
        public string parentName { get; set; }
    
        [Display(Name = "Parent Phone")]
        public string parentPhoneNo { get; set; }
        [Display(Name = "Class Choosen")]
        public string classChoosen { get; set; }
        [Display(Name = "Passport")]
        public string passportUrl { get; set; }
        [Display(Name = "Date Submitted")]
        public DateTime dateSubmitted { get; set; }

        [Display(Name = "Date Accepted")]
        public DateTime dateAcceped { get; set; }

    }
}