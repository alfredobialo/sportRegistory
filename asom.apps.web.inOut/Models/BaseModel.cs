using System;

namespace asom.apps.web.inOut.Models
{
    [Serializable]
    public abstract class BaseModel
    {
        public BaseModel()
        {
            IsActive = true;
            DateCreated = DateTime.UtcNow;
            IsEditMode = false;
        }
        private string id;

        public string Id
        {
            get
            {
                return id;

            }
            set
            {
                if (value != null  && value.Length > 50)
                    value = value.Substring(0, 49);
                id = value;
            }
        }

        public bool IsEditMode { get; set; }

        public string CreatedAtChannel { get; set; }

        public string CreatedBy
        { get; set; }

        public DateTime? DateCreated { get; set; }
        public bool? IsActive
        { get; set; }
        public DateTime? DateUpdated { get; set; }

    }
}