using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model
{
    public class DefaultPersistable<T>  : DefPersistable<T>
    {
       

        
        private string cu = null;

        public DefaultPersistable()
        {
            CreateById  = HasUserContext ? CurrentUserContext?.Id?.ToString() : null;
            
        }
        public string OrgId { get; internal set; } = OrganizationInfo.ORG_CODE;

        /// <summary>
        /// Get the Id of the user who created this object
        /// </summary>
        public string CreateById
        {
            get
            {
                return cu;
            }
            internal set { cu = value; }
        }



    }
}
