using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;

namespace asom.apps.web.inOut.Model
{
    public class MediaObjModel
    {
        public string MediaType { get; set; }
        public string MediaUrl { get; set; }
        public string MediaTag { get; set; }
        public string ObjId { get; set; }
        public string Id { get; set; }

        public bool HasUrl => !string.IsNullOrEmpty(MediaUrl);

       
        
        public static implicit operator MediaObjModel(MediaObject o)
        {
            MediaObjModel res  =  new MediaObjModel();
            res.Id = o.Key;
            res.ObjId = o.ObjId;
            res.MediaTag = o.MediaTag;
            res.MediaType = o.MediaType;
            res.MediaUrl = MyConfig.GenerateFileUrl(o.MediaUrl);
            if(!string.IsNullOrEmpty(res.MediaUrl))
            {
                res.MediaUrl = MyConfig.GenerateUrlWithDomainName(o.MediaUrl);
            }



            return res;
            }



    }
}