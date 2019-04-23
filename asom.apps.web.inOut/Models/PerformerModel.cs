using System;
using System.Linq;
using asom.apps.inOut.core.model.sports;
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

        public static implicit operator PerformerModel(Performer o)
        {
            return new PerformerModel
            {
                Id = o.Key,
                Age = o.Age,
                Nationality = o.Nationality,
                LastName = o.LastName,
                FirstName = o.FirstName
            };
        }

        public static explicit operator Performer(PerformerModel o)
        {
            return new Performer
            {
                Id = o.Id,
                Age = o.Age,
                Nationality = o.Nationality,
                LastName = o.LastName,
                FirstName = o.FirstName
            };
        }

        public static ServerResponseModel CreatePerformer(PerformerModel o)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Not Created!, try again";
            res.Success = false;
            Performer p = (Performer) o;
            var crud = p.Save();
            res = ServerResponseModel.From(crud);
            if (crud.IsSuccess)
            {
                res.Data = (PerformerModel) crud.Data;
            }

            return res;
        }

        public static ServerResponseModel UpdatePerformer(PerformerModel o)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Not Updated!, try again";
            res.Success = false;
            Performer p = (Performer) o;
            var crud = p.Update();
            res = ServerResponseModel.From(crud);
            if (crud.IsSuccess)
            {
                res.Data = (PerformerModel) crud.Data;
            }

            return res;
        }

        public static ServerResponseModel GetPerformers(Criteria criteria)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Could not Load records, try again";
            res.Success = false;

            var crud = Performer.Get(criteria);
            res = ServerResponseModel.From(crud);
            if (crud.IsSuccess)
            {
                res.Data = crud.Data.Select(x => (PerformerModel) x).ToList();
            }

            return res;
        }

        public static ServerResponseModel GetPerformer(string id)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Could not Load records, try again";
            res.Success = false;

            var crud = Performer.Get(id);
            res = ServerResponseModel.From(crud);
            if (crud.IsSuccess)
            {
                res.Data = (PerformerModel) crud.Data;
            }

            return res;
        }

        public static ServerResponseModel DeletePerformer(string id)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Not Updated!, try again";
            res.Success = false;
            Performer p = new Performer() {Id = id};
            var crud = p.Delete();
            res = ServerResponseModel.From(crud);
            if (crud.IsSuccess)
            {
                res.Data = (PerformerModel) crud.Data;
            }

            return res;
        }
    }

    public class JudgeScoreModel
    {
        public decimal? ScoreTechnical { get; set; }
        public decimal? ScoreAthlete { get; set; }
        public string GroupId { get; set; }
        public string JudgeId { get; set; }
        public string PerformerId { get; set; }

        public PerformerModel Performer { get; internal set; }

        public static ServerResponseModel CreateJudgeScoreEntry(JudgeScoreModel j)
        {
            // Create two judge Score record
            ServerResponseModel res = new ServerResponseModel();
            res.Message = "Entry not Created!";
            try
            {
                JudgeScore techie = new JudgeScore()
                {
                    PermormerId = j.PerformerId,
                    GroupId = j.GroupId,
                    SportType = "-",
                    TechnicalScore = j.ScoreTechnical,
                    AthleticScore =  j.ScoreAthlete
                };
                
                var crud  = techie.CreateEntry();
                res = ServerResponseModel.From(crud);
                if (crud.IsSuccess)
                {res.Message = "Entry was Saved Successfully";
                   res.Success = true;
                   
                }
                
            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "Could not create entry, try again";
            }

            return res;
        }

        public static JudgeScoreModel FromEntity(JudgeScore o)
        {
            return new JudgeScoreModel()
            {
                Performer = o.PerformerInfo,
                GroupId = o.GroupId,
                PerformerId = o.PermormerId,
                   ScoreTechnical = o.TechnicalScore,
                   ScoreAthlete = o.AthleticScore,
                   JudgeId = o.JudgeId
            };
        }
    }
}