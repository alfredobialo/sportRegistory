namespace asom.apps.inOut.core.model.org
{
    public class ObjSearchCriteria : BaseCriteria
    {
        private bool fbc, saf = false;
        private string qs;

        public ObjSearchCriteria()
        {
            FindByObj = true;
        }

        public bool SortById { get; set; }
        public bool SortAscending { get; set; }

        public bool FindByObj
        {
            get { return fbc; }

            set
            {
                fbc = value;
                SearchInAllFields = !value;
            }
        }

        public string QueryString
        {
            get ;//{ return qs; }
            set ;//{ qs = value.Trim(); }
        }

        public bool SearchInAllFields
        {
            get
            {
                return saf;
            }
            set
            {
                saf = value;
                //FindByObj = !value;
            }
        }

        public bool ShowAllRecord { get; set; }
       
    }
}
