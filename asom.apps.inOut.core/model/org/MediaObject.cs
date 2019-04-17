using System;
using System.Collections.Generic;
using asom.apps.inOut.core.dal.sqlserver.model;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.util;

namespace asom.apps.inOut.core.model.org
{
    public class MediaObject : DefaultPersistable<MediaObject>
    {
        public const string MEDIA_TYPE_IMAGE = "image";
        public const string MEDIA_TYPE_VIDEO = "video";
        public static MediaObject GetById(string id)
        {
            return new MediaObject().Find(id);
        }

        public static IEnumerable<MediaObject> GetMediaByObjectId(string id)
        {

            return GetMediaByObjectId(id, true);
        }
        public static IEnumerable<MediaObject> GetMediaByObjectId(string id, bool randomize)
        {
            List<MediaObject> MediaObject = new MediaObject().Find(new Criteria() { Id = id }) as List<MediaObject>;
            if (MediaObject != null)
            {
                if (randomize)
                {
                    MediaObject = RadomizeMediaIndexes(MediaObject);
                }

            }
            return MediaObject;
        }
        internal static MediaObject NewMediaObject(string objId, string mediaType, string mediaUrl, string mediaTag = "")
        {
            MediaObject res = new MediaObject();

            res.MediaUrl = mediaUrl;
            res.MediaType = mediaType;
            res.ObjId = objId;
            res.MediaTag = mediaTag;
            res.IsActive = true;

            return res;
        }
        public static MediaObject NewImageMedia(string objId, string mediaUrl, string imageTag = "")
        {
            return NewMediaObject(objId, MEDIA_TYPE_IMAGE, mediaUrl, imageTag);
        }
        public static MediaObject NewVideoMedia(string objId, string mediaUrl, string videoTag = "")
        {
            return NewMediaObject(objId, MEDIA_TYPE_VIDEO, mediaUrl, videoTag);
        }
        internal static List<MediaObject> RadomizeMediaIndexes(List<MediaObject> media)
        {
            RandomSelector<List<MediaObject>, MediaObject> random
                = new RandomSelector<List<MediaObject>, MediaObject>(media);
            random.Limit = media.Count;
            return random.Randomize(media.Count);

        }
        public MediaObject()
        {
            MediaType = MEDIA_TYPE_IMAGE;
        }
        public string MediaType { get; set; }
        public string MediaUrl { get; set; }
        public string MediaTag { get; set; }
        public string ObjId { get; set; }
        public override DefRepository<MediaObject> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<MediaObject>.DataSource ?? new MediaRepo();
        }

        public DateTime? DatePosted
        {
            get { return DateInitialized; }
            set { DateInitialized = value; }
        }

        public bool? IsActive
        {
            get { return IsOn; }
            set { IsOn = value; }
        }
        public string GroupId { get; set; }


        internal void Save()
        {
            SaveSelf(this, true);
        }

        internal static void Save(IEnumerable<MediaObject> objs)
        {
            new MediaObject().SaveSelf(objs);
        }

        public static void SaveMedia(IEnumerable<MediaObject> obj)
        {
            foreach (var m in obj)
            {
                m.Save();
            }
        }
        public void Delete()
        {

            DeleteSelf(this);
        }


        internal static void Save(IHasMediaObject obj)
        {

            Save(obj.Media);
        }
    }

    public interface IHasMediaObject
    {
        string Key { get; set; }
        IEnumerable<MediaObject> Media { get; set; }
    }
}
