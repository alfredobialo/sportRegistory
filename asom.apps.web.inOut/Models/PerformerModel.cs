using itrex.businessObjects.model.core;

namespace asom.apps.web.inOut.Models
{
    public class PerformerModel
    {
        public string FirstName { get; set; }
        public string Id { get; set; }
        public string LastName { get; set; }
        public string DisplayName => $"{FirstName ?? ""} {LastName ?? ""}";
        public string Nationality { get; set; }
        public byte? Age { get; set; }
        public static ServerResponseModel CreatePerformer(PerformerModel performerModel)
        {
            throw new System.NotImplementedException();
        }

        public static ServerResponseModel UpdatePerformer(PerformerModel performerModel)
        {
            throw new System.NotImplementedException();
        }

        public static ServerResponseModel GetPerformers(Criteria criteria)
        {
            throw new System.NotImplementedException();
        }

        public static ServerResponseModel GetPerformer(string id)
        {
            throw new System.NotImplementedException();
        }

        public static ServerResponseModel DeletePerformer(string id)
        {
            throw new System.NotImplementedException();
        }
    }
}