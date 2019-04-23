using System;
using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.authentication;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.pager;

namespace asom.apps.inOut.core.model.sports
{
    public class ResultJudgeScoreCriteria : Criteria
    {
        public ResultJudgeScoreCriteria()
        {
          
        }

        public string PerformerId { get; set; }
        public string GroupId { get; set; }
        
    }
    public class JudgeScore  :DefaultPersistable<JudgeScore>
    {
        public enum GroupType
        {
            AKA = 1,
            AO
        };
        public JudgeScore()
        {
            JudgeId = CurrentUserContext.Id.ToString();
        }

        public string GroupId { get; set; } = GroupType.AKA.ToString();
        public decimal? Score { get; set; }
        public decimal? TechnicalScore { get; set; }
        public decimal? AthleticScore { get; set; }
        public string PermormerId { get; set; }

        public Performer PerformerInfo { get; internal set; }
        public string JudgeId { get; internal set; }
        public string SportType { get; set; }
        public bool IsExcluded { get; internal set; } = false;
        
        public DateTime? DateCreated { get => DateInitialized; set => DateInitialized = value; }

        public override IValidationError Validate()
        {
            ValidationErrorLog errorLog =  new ValidationErrorLog();
            // check if the score is in valid range of 5.0  and 10.0
            if (TechnicalScore < 5.0m || TechnicalScore > 10.0m)
            {
                errorLog.AddError("Technical Score range not Met",Score.ToString(), $"Technical Score should be between 5.0 and 10.0");
            } 
            if (AthleticScore < 5.0m || AthleticScore > 10.0m)
            {
                errorLog.AddError("Athletic Score range not Met",Score.ToString(), $"Athletic Score should be between 5.0 and 10.0");
            }
            
            return errorLog;
        }

        public CrudOperationResult<JudgeScore> CreateEntry()
        {
            return CreateObject(this);
        }  
        public CrudOperationResult<JudgeScore> RemoveEntry()
        {
            return DeleteObject(this);
        } 
        public CrudOperationResult<JudgeScore> CreateOrUpdateEntry()
        {
            return CreateOrUpdateObject(this);
        }

        public static CrudOperationResult<JudgeScore> GetEntry(string id)
        {
            return new JudgeScore().FindObject(id);
        }

        public static CrudOperationResult<IEnumerable<JudgeScore>> GetEntries(Criteria criteria)
        {
            return new JudgeScore().FindObject(criteria);
        }
        
        public override DefRepository<JudgeScore> GetDefaultDataSource()
        {
            return new JudgeScoreRepo();
        }
    }

    public class JudgeScoreRepo : SqlServerDal<JudgeScore>
    {
        judgeScore toEntity(judgeScore e, JudgeScore o)
        {
            e.id = o.Key;
            e.score = o.Score ?? 0.0m;
            e.judgeId = o.JudgeId;
            e.groupId = o.GroupId;
            e.sportType = o.SportType;
            e.performerId = o.PermormerId;
            e.dateFilter = o.DateCreated;
            e.techScore = o.TechnicalScore ?? 0;
            e.athleScore = o.AthleticScore ?? 0;
            return e;
        }

        judgeScore toEntity(JudgeScore o)
        {
            return toEntity(new judgeScore(), o);
        }

        JudgeScore fromEntity(judgeScore e)
        {
            JudgeScore res  =  new JudgeScore();
            res.Key = e.id;
            res.Score = e.score;
            res.GroupId = e.groupId;
            res.JudgeId = e.judgeId;
            res.SportType = e.sportType;
            res.DateCreated = e.dateFilter;
            res.PermormerId = e.performerId;
            res.TechnicalScore = e.techScore;
            res.AthleticScore = e.athleScore;
            // get the performer
            res.PerformerInfo = Performer.Get(e.performerId).Data;
            return res;
        }

        public override CrudOperationResult<JudgeScore> CreateObject(JudgeScore obj)
        {
            // create a new JudgeScore object
            var res =  new CrudOperationResult<JudgeScore>();
            res.Data = obj;
            res.Message = "Score not Created!";
            res.IsSuccess = false;

            try
            {
                // check if object exist 
                if (!IsFound(obj))
                {
                    var e = toEntity(obj);
                    db.judgeScore.Add(e);
                    Save();
                    res.Message = "Judge Score entry saved successfully!";
                    res.IsSuccess = true;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                    
                }
                else
                {
                    res.Message = $"Score Entry for the selected performer Already exist";
                    
                }
            }
            catch (Exception err  )
            {
                res.ServerException = err;
                res.Message = "An internal server error occurred.";
            }
            
            return res;
        }

        public override CrudOperationResult<JudgeScore> UpdateObject(JudgeScore obj)
        {
            var res  =  new CrudOperationResult<JudgeScore>();
            res.Message = "Update was not successful";
            res.IsSuccess = true;
            res.Data = obj;
            // no exception check
            try
            {
                var data = db.judgeScore.FirstOrDefault(x => x.id == obj.Key);
                if (data != null)
                {
                    toEntity(data, obj);
                    Save();
                    res.IsSuccess = true;
                    res.Message = "Record updated";
                }
            }
            catch (Exception err)
            {
                res.Message = "An error occurred while trying to update record";
                res.ServerException = err;
            }
            
            return res;
        }

        public override CrudOperationResult<IEnumerable<JudgeScore>> FindObject(Criteria criteria)
        {
            var res  = new CrudOperationResult<IEnumerable<JudgeScore>>();
            res.Data   = new List<JudgeScore>();
            /*
             * We may ignore the criteria and work with the currently logged in user
             *so :  if the current user has the Standard User Permission, the we assume is a Jugde
             * and we are to filter the JudgeScores based on the judges id
             *
             * if is an admin user, then we are return all judges Scores
             * 
             */
            try
            {
                var currentUserId = CurrentUserContext.Id.ToString();  // for filtering
                // Check for access right without throwing Exception
                bool hasAdminRight = HasAuthority(AppPermissions.CORE_APP_FUNCTIONS_MANAGER), 
                    hasJudegsAccess  = HasAuthority(AppPermissions.STANDARD_USER_BONUS);
                IEnumerable<judgeScore> data = new List<judgeScore>();
                if (hasJudegsAccess && !hasAdminRight)
                {
                    // Do this for judges
                    // the double check is to ensure that we don't include an admin user .
                    //check if criteria is supplied
                    if (criteria != null && !string.IsNullOrEmpty(criteria.Id))
                    {
                        // we assume the group type is stored in the id property for this criteria
                        data = db.judgeScore.Where(x => x.judgeId == currentUserId &&  x.groupId == criteria.Id)
                        .OrderBy(x =>x.dateFilter);
                    }
                    else
                    {
                         data = db.judgeScore.Where(x => x.judgeId == currentUserId)
                         .OrderBy(x =>x.dateFilter);
                    }
                   
                }
                else if(hasAdminRight)
                {
                    // admin user
                    // TODO :check if we need more modifications here
                    if (criteria != null && criteria is ResultJudgeScoreCriteria)
                    {
                            // get by group id, player 
                            ResultJudgeScoreCriteria cri  = criteria as ResultJudgeScoreCriteria;
                            data = db.judgeScore.Where(
                                x => x.groupId == cri.GroupId && x.performerId == cri.PerformerId)
                                .OrderBy(x => x.judgeId);
                            
                    }
                   
                }

                res.Data = data.Select(fromEntity);
                res.Message = "Score result loaded";
                res.IsSuccess = true;

            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "An internal server error occurred while attempting to retrieve Judges Scores";
            }
            return res;
        }

        public override CrudOperationResult<JudgeScore> FindObject(object id)
        {
            var res  = new CrudOperationResult<JudgeScore>();
            res.IsSuccess = false;
            res.Message = "Record not found";
            JudgeScore js  = new JudgeScore(){Id = id};
            var e = db.judgeScore.FirstOrDefault(x => x.id == js.Key);
            if (e != null)
            {
                js = fromEntity(e);
                res.IsSuccess = true;
                res.Message = "Record Loaded!";
                res.Data = js;
            }
            return res;
        }

        public override bool IsFound(JudgeScore obj)
        {
            // Ensure only one record Per Judge per User per Group
          //  string currentJudge = CurrentUserContext.Id.ToString();
           return db.judgeScore.Any(x=>x.groupId  == obj.GroupId 
                                       && x.judgeId == obj.JudgeId
                                       //&& x.sportType == obj.SportType
                                       && x.performerId == obj.PermormerId);
        }
    }
}