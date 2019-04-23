using System;
using System.Linq;
using System.Web.Mvc;
using asom.apps.inOut.core.model.sports;
using asom.apps.web.inOut.Controllers.BaseControllers;
using asom.apps.web.inOut.Models;
using itrex.businessObjects.model.core;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Controllers
{
    public class SportsController : SecuredAppController
    {
        // GET
        private ActionResult GetAppInfo()
        {
            return CrudOperaResult(new ServerResponseModel() {Data = AppInfo.Get, Message = "Application Info", Success = true});

        }

        //Key 10
        [HttpPost]
        ActionResult CreatePerformer(string obj)
        {
            ServerResponseModel res =  new ServerResponseModel();
            try
            {
                PerformerModel p = JsonConvert.DeserializeObject<PerformerModel>(obj, MyConfig.DefaultJsonSettings);
                res = PerformerModel.CreatePerformer(p);
            }
            catch (Exception err)
            {
                res.Message = "Web layer exception occured";
                res.ServerException = err;

            }

            return CrudOperaResult(res);

        }
        [HttpPost]
        ActionResult UpdatePerformer(string obj)
        {
            ServerResponseModel res =  new ServerResponseModel();
            try
            {
                PerformerModel p = JsonConvert.DeserializeObject<PerformerModel>(obj, MyConfig.DefaultJsonSettings);
                res = PerformerModel.UpdatePerformer(p);
            }
            catch (Exception err)
            {
                res.Message = "Web layer exception occured";
                res.ServerException = err;

            }

            return CrudOperaResult(res);

        }
        ActionResult GetPerformers(string criteria)
        {
            ServerResponseModel res =  new ServerResponseModel();
            try
            {
                Criteria p = JsonConvert.DeserializeObject<Criteria>(criteria, MyConfig.DefaultJsonSettings);
                res = PerformerModel.GetPerformers(p);
            }
            catch (Exception err)
            {
                res.Message = "Web layer exception occured";
                res.ServerException = err;

            }

            return CrudOperaResult(res);

        }
        ActionResult GetPerformer(string id)
        {
            ServerResponseModel res =  new ServerResponseModel();
            try
            {
                // PerformerModel p = JsonConvert.DeserializeObject<PerformerModel>(obj, MyConfig.DefaultJsonSettings);
                res = PerformerModel.GetPerformer(id);
            }
            catch (Exception err)
            {
                res.Message = "Web layer exception occured";
                res.ServerException = err;

            }

            return CrudOperaResult(res);

        } 
        [HttpPost]
        ActionResult DelPerformer(string id)
        {
            ServerResponseModel res =  new ServerResponseModel();
            try
            {
                // PerformerModel p = JsonConvert.DeserializeObject<PerformerModel>(obj, MyConfig.DefaultJsonSettings);
                res = PerformerModel.DeletePerformer(id);
            }
            catch (Exception err)
            {
                res.Message = "Web layer exception occured";
                res.ServerException = err;

            }

            return CrudOperaResult(res);

        }

        private ActionResult CreateJudgeScoreEntry(string entry)
        {
            ServerResponseModel res =   new ServerResponseModel();
            try
            {
                JudgeScoreModel model =
                    JsonConvert.DeserializeObject<JudgeScoreModel>(entry, MyConfig.DefaultJsonSettings);
                res = JudgeScoreModel.CreateJudgeScoreEntry(model);
            }
            catch (Exception err)
            {
                res.Message = "Web layer internal error!";
                res.ServerException = err;
            }
         
            return CrudOperaResult(res);
        }
        
        private ActionResult GetJudgeScoreEntry(string criteria)
        {
            ServerResponseModel res =   new ServerResponseModel();
            try
            {
                Criteria model =
                    JsonConvert.DeserializeObject<Criteria>(criteria, MyConfig.DefaultJsonSettings);
                var crud = JudgeScore.GetEntries(model);
                
                res  = ServerResponseModel.From(crud);
                if (res.Success)
                {
                    res.Data = crud.Data.Select(x => JudgeScoreModel.FromEntity(x));
                }
            }
            catch (Exception err)
            {
                res.Message = "Web layer internal error!";
                res.ServerException = err;
            }

            return CrudOperaResult(res);
        }
        private ActionResult GetJudgeScoreResult(string criteria)
        {
            ServerResponseModel res =   new ServerResponseModel();
            try
            {
                ResultJudgeScoreCriteria model =
                    JsonConvert.DeserializeObject<ResultJudgeScoreCriteria>(criteria, MyConfig.DefaultJsonSettings);
                var crud = JudgeScore.GetEntries(model);
                
                res  = ServerResponseModel.From(crud);
                if (res.Success)
                {
                    //res.ExtraData = crud.Data;
                    res.Data = crud.Data.Select(x => JudgeScoreModel.FromEntity(x));
                }
            }
            catch (Exception err)
            {
                res.Message = "Web layer internal error!";
                res.ServerException = err;
            }

            return CrudOperaResult(res);
        }

        public override ActionResult GetUrl(int? key, string data, string criteria, string extradata = null, bool trueFalse = false)
        {
            switch (key)
            {
                case 1 :
                    return GetAppInfo();
                case 10 :
                    return CreatePerformer(data);
                case 20 :
                    return UpdatePerformer(data);
                case 30 :
                    return GetPerformer(data);
                case 40 :
                    return GetPerformers(criteria);
                case 50 :
                    return DelPerformer(data);
                case 200 :
                    return CreateJudgeScoreEntry(data);
                case 201 :
                    return GetJudgeScoreEntry(criteria);
                case 2011 :
                    return GetJudgeScoreResult(criteria);
            }
            return base.GetUrl(key, data, criteria, extradata, trueFalse);
        }
    }
}