using System;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal.sqlserver.model
{
    public class OrgRepo : SqlServerDal<OrganizationInfo>
    {
        protected internal OrgRepo()
        {

        }
        public override void Save(OrganizationInfo obj)
        {
            org_company_profile e = toEntity(obj);
            db.org_company_profile.Add(e);
            Save();
        }

        public override bool IsFound(OrganizationInfo obj)
        {
            return db.org_company_profile.Any(x => x.id == obj.Key);
        }

        public override void Update(OrganizationInfo obj)
        {
            var data = db.org_company_profile.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                data = toEntity(data, obj);
                Save();
            }

        }

        public override OrganizationInfo Get(object id)
        {
            OrganizationInfo res =  new OrganizationInfo() {Id = id};
            try
            {
                //using (InOutDataModel db.)
                var data = db.org_company_profile.FirstOrDefault(x =>x.id ==  res.Key);
                if (data != null)
                {
                    res = fromEntity(data);
                }
                else
                {
                    res = null;
                }
            }
            catch (Exception err)
            {


            }

            return res;
        }

        OrganizationInfo fromEntity(org_company_profile e)
        {
            OrganizationInfo res =   new OrganizationInfo();

            res.Name = e.name;
            res.Slogan = e.slogan;
            res.LogoBlob = e.logoBlob;
            res.LogoUrl = e.logoUrl;
            res.SecondaryLogoUrl = e.secondaryLogoUrl;
            res.SignatureBlob = e.signatureBlob;
            res.SignatureUrl = e.signatureUrl;
            res.Note = e.note;
            res.DateInitialized = e.dateCreated;
            res.Id = e.id;
            res.Website = e.website;
            res.Email = e.email;
            res.ChannelInfo  = BusinessChannel.GetDefault();
            res.AboutTheCompany = e.aboutCompany;
            res.Faq = e.faq ?? "";
            res.Extra1 = e.extra1 ?? "";
          res.Extra2 = e.extra2 ?? "";
          res.Extra3 = e.extra3 ?? "";
            if (string.IsNullOrEmpty(res.Name)) res.Name = "Your Company Name";

            return res;
        }
        private org_company_profile toEntity(OrganizationInfo o)
        {
            return toEntity(new org_company_profile(), o);
        }

        public override CrudOperationResult<OrganizationInfo> CreateObject(OrganizationInfo obj)
        {
            return base.CreateObject(obj);
        }

        public override CrudOperationResult<OrganizationInfo> DeleteObject(OrganizationInfo obj)
        {
            return base.DeleteObject(obj);
        }

        public override CrudOperationResult<OrganizationInfo> FindObject(object id)
        {
            return base.FindObject(id);
        }

        private org_company_profile toEntity(org_company_profile e, OrganizationInfo o)
        {
            e.dateCreated = o.DateInitialized;
            e.id = o.Key;
            e.logoBlob = o.LogoBlob;
            e.signatureBlob = o.SignatureBlob;
            e.logoUrl = o.LogoUrl;
            e.signatureUrl = o.SignatureUrl;
            e.name = o.Name;
            e.note = o.Note;
            e.secondaryLogoUrl = o.SecondaryLogoUrl;
            e.slogan = o.Slogan;
            e.email = o.Email;
            e.website = o.Website;
            e.aboutCompany = o.AboutTheCompany;
          e.faq = o.Faq;
          e.extra1 = o.Extra1;
          e.extra2 = o.Extra2;
          e.extra3 = o.Extra3;
            //db.org_company_profile.Add(e);
            //Save();
            return e;
        }

    }
}
