using System;
using System.Web.Mvc;
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
            }
            return base.GetUrl(key, data, criteria, extradata, trueFalse);
        }
    }
}