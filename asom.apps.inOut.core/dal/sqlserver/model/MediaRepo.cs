using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver.db;
using asom.apps.inOut.core.model.org;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal.sqlserver.model
{
    public  class MediaRepo  : SqlServerDal<MediaObject>
    {
        org_media_store toEntity(org_media_store e, MediaObject media)
        {
            e.media_owner_id = media.ObjId;
            e.id = media.Key;
            e.media_tag = media.MediaTag;
            e.media_type = media.MediaType;
            e.media_owner_group = media.GroupId;
            e.is_active = media.IsActive;
            e.date_created = media.DatePosted;
            e.media_file_url = media.MediaUrl;
            

            return e;
        }

        private org_media_store toEntity(MediaObject media)
        {
            return toEntity(new org_media_store(), media);
        }

        public override void Save(IEnumerable<MediaObject> obj)
        {
            //base.Save(obj);
            // Else
            // For Batch Saving
            foreach (var MediaObject in obj)
            {
                db.org_media_store.Add(toEntity(new org_media_store(), MediaObject));
            }
            Save();
        }



        MediaObject fromEntity(org_media_store e)
        {
            MediaObject res = new MediaObject();
            res.Key = e.id;
            res.DatePosted = e.date_created;
            res.MediaTag = e.media_tag;
            res.MediaType = e.media_type;
            res.ObjId = e.media_owner_id;
            res.IsActive = e.is_active;
            res.MediaUrl = e.media_file_url;
            res.GroupId = e.media_owner_group;
            return res;
        }
        public override void Save(MediaObject obj)
        {
            // Save 
            db.org_media_store.Add(toEntity(new org_media_store(), obj));
            Save();
        }


        public override MediaObject Get(object id)
        {
            MediaObject res = new MediaObject() { Id = id };
            var data = db.org_media_store.FirstOrDefault(x => x.id == res.Key);
            if (data != null)
            {
                res = fromEntity(data);
            }
            else
            {
                res = null;
            }
            return res;
        }

        public override IEnumerable<MediaObject> Get(Criteria criteria)
        {
            List<MediaObject> res = new List<MediaObject>();
            if (criteria != null && !string.IsNullOrEmpty(criteria.Id))
            {
                // We Get Medias by Pub Id
                var data = db.org_media_store.Where(x => x.media_owner_id == criteria.Id
                        && x.is_active == true);

                foreach (var item in data)
                {
                    MediaObject pm = fromEntity(item);
                    res.Add(pm);

                }
            }
            return res;
        }


        public override bool IsFound(MediaObject obj)
        {
            return db.org_media_store.Any(x => x.id == obj.Key);
        }

        public override void Delete(MediaObject obj)
        {
            var data = db.org_media_store.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                data.is_active = false;
                Save();
            }
            //base.Delete(obj);
        }

        public override void Update(MediaObject obj)
        {
            var data = db.org_media_store.FirstOrDefault(x => x.id == obj.Key);
            if (data != null)
            {
                toEntity(data, obj);
                Save();
            }
        }
    }
}
