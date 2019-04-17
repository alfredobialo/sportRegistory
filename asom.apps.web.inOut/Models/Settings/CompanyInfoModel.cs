using System;
using System.Collections.Generic;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;

namespace asom.apps.web.inOut.Models.Settings
{
    [Serializable]
    public class CompanyInfoModel :BaseModel
    {
        public static IEnumerable<CompanyInfoModel> GetCompanyModel()
        {
            return new List<CompanyInfoModel>();
        }

      public string Name { get; set; } = "Your Company Name";
        public string Slogan { get; set; }
        public string LogoUrl { get; set; }
        public string Website { get; set; }
        public string Email { get; set; }
        public string SignatureUrl { get; set; }
        public string SecondaryLogoUrl { get; set; }
        public string Note { get; set; }
          public string AboutCompany { get; set; }
        public byte[] LogoBlob { get; set; }
        public byte[] SignatureBlob { get; set; }
      public string Faq { get; set; }=  "";
      public string Extra1 { get; set; }=  "";
      public string Extra2 { get; set; }=  "";
      public string Extra3 { get; set; }=  "";
//        public string Id { get; set; }

        public BusinessChannelModel ChannelInfo { get; set; }

        public static CompanyInfoModel Get
        {
            get { return OrganizationInfo.Get(); }

        }
        public static implicit operator CompanyInfoModel(OrganizationInfo org)
        {
            CompanyInfoModel res =  new CompanyInfoModel();
            res.Id = org.Key;
            res.Name = string.IsNullOrEmpty(org.Name) ? AppInfo.Get.LicenseToCompany : org.Name;
            res.LogoUrl = string.IsNullOrEmpty(org.LogoUrl) ?
                AppInfo.Get.AppLogoUrl  : MyConfig.GetDefaultUrlWithDomainNameIfEmpty(org.LogoUrl,AppInfo.Get.AppLogoUrl);
            res.LogoBlob = org.LogoBlob;
            res.Note = org.Note;
            res.SecondaryLogoUrl = string.IsNullOrEmpty(org.SecondaryLogoUrl) ?
                AppInfo.Get.AppIconUrl  : MyConfig.GetDefaultUrlWithDomainNameIfEmpty(org.SecondaryLogoUrl, AppInfo.Get.AppIconUrl);
            res.SignatureBlob = org.SignatureBlob;
            res.SignatureUrl  = string.IsNullOrEmpty(MyConfig.GenerateFileUrl(org.SignatureUrl)) ?
                "" : MyConfig.GenerateUrlWithDomainName(org.SignatureUrl);
            res.Slogan = org.Slogan;
            res.Website = org.Website;
            res.Email = org.Email;
            res.ChannelInfo = org.ChannelInfo;
          res.AboutCompany = org.AboutTheCompany;
          res.Faq = org.Faq;
          res.Extra1 = org.Extra1;
          res.Extra2 = org.Extra2;
          res.Extra3 = org.Extra3;
//            res.Address = org.ChannelInfo.Address;
//            res.PhoneNumber = org.ChannelInfo.PhoneNumber;
//            res.City = org.ChannelInfo.City;
//            res.Location = org.ChannelInfo.Location;

            return res;
        }

        public string City { get; set; }

        public string Location { get; set; }

        public string PhoneNumber { get; set; }

        public string Address { get; set; }


        public static explicit operator OrganizationInfo(CompanyInfoModel org)
        {
            OrganizationInfo res =  OrganizationInfo.Get();
            res.Id = org.Id;
            res.Name = org.Name;
            res.LogoUrl = MyConfig.RemoveDomainName(org.LogoUrl);
            res.LogoBlob = org.LogoBlob;
            res.Note = org.Note;
            res.SecondaryLogoUrl = MyConfig.RemoveDomainName(org.SecondaryLogoUrl);
            res.SignatureUrl = MyConfig.RemoveDomainName(org.SignatureUrl);
            res.SignatureBlob = org.SignatureBlob;
            res.Slogan = org.Slogan;
            res.Website = org.Website;
            res.AboutTheCompany = org.AboutCompany;
            res.Email = org.Email;
            res.ChannelInfo.Address = org.ChannelInfo.Address;
            res.ChannelInfo.City  =  org.ChannelInfo.City;
            res.ChannelInfo.PhoneNumber  =  org.ChannelInfo.PhoneNumber;
            res.ChannelInfo.Location  =  org.ChannelInfo.Location;
          res.Faq = org.Faq;
          res.Extra1 = org.Extra1;
          res.Extra2 = org.Extra2;
          res.Extra3 = org.Extra3;
            //res.ChannelInfo.  =  org.ChannelInfo.PhoneNumber;
            return res;
        }


    }
}
