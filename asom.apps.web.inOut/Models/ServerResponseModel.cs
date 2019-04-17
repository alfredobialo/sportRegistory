using System;
using itrex.businessObjects.model.core;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Models
{
    public class ServerResponseModel<T>
    {
        public String Message { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public object ExtraData { get; set; }
        public bool IsSuccess { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore, DefaultValueHandling = DefaultValueHandling.Ignore)]
        public bool IsArray { get; set; }
        public T Data { get; set; }
        public bool IsAuthorize { get; set; }
        private Exception myVar;

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public Exception ServerException
        {
            get { return myVar; }
            set
            {
                myVar = value;
                HasException = myVar != null;

            }
        }


        public bool HasException { get; set; }
        /// <summary>
        /// Get the criteria object used on the server. this is useful when paginating thru record
        /// </summary>
        public Criteria Criteria { get; set; }

        public IValidationError ValidationErrors { get; set; }

        public static implicit operator ServerResponseModel<T>(CrudOperationResult<T> o)
        {
            ServerResponseModel<T> res  =  new ServerResponseModel<T>();
            res.Message = o.Message;
            res.Criteria = o.Criteria;
            res.Data = o.Data;
            res.HasException = o.HasException;
            res.IsArray = o.IsArray;
            res.IsAuthorize = o.IsAuthorize;
            res.IsSuccess = o.IsSuccess;
            res.ServerException = res.ServerException;
            res.ValidationErrors = o.ValidationErrors;
            res.ExtraData = o.ExtraData;
            return res;
        }


        
    }
    public class ServerResponseModel
    {

        public String Message { get; set; }
        public object ExtraData { get; set; }
        public bool Success { get; set; }
        public bool IsArray { get; set; }
        public dynamic Data { get; set; }
        public bool IsAuthorize { get; set; }
        private Exception myVar;

        public Exception ServerException
        {
            get { return myVar; }
            set
            {
                myVar = value;
                HasException = myVar != null;

            }
        }


        public bool HasException { get; set; }
        /// <summary>
        /// Get the criteria object used on the server. this is useful when paginating thru record
        /// </summary>
        public Criteria Criteria { get; set; }

        public IValidationError ValidationErrors { get; set; }

        public static ServerResponseModel From<T>(CrudOperationResult<T> o)
        {
            ServerResponseModel res = new ServerResponseModel();
            res.Message = o.Message;
            res.Criteria = o.Criteria;
            res.Data = o.Data;
            res.HasException = o.HasException;
            res.IsArray = o.IsArray;
            res.IsAuthorize = o.IsAuthorize;
            res.Success = o.IsSuccess;
            res.ServerException = o.ServerException;
            res.ValidationErrors = o.ValidationErrors;
            res.ExtraData = o.ExtraData;
            return res;
        }



    }
}