using System;
using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver;
using asom.apps.inOut.core.dal.sqlserver.db;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.model.sports
{
    public interface IPerformer
    {
        string DisplayName { get; }
        string Key { get; set; }
        string Nationality { get; set; }
    }

    public class Performer : DefaultPersistable<Performer>, IPerformer
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DisplayName => $"{FirstName ?? ""} {LastName ?? ""}";
        public string Nationality { get; set; }
        public byte? Age { get; set; }

        public override DefRepository<Performer> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<Performer>.DataSource ?? new PerformerRepo();
        }

        public CrudOperationResult<Performer> Save()
        {
            return CreateObject(this);
        }public CrudOperationResult<Performer> Delete()
        {
            return DeleteObject(this);
        }

        public CrudOperationResult<Performer> Update()
        {
            return UpdateObject(this);
        }

        public static CrudOperationResult<Performer> Get(string id)
        {
            return new Performer().FindObject(id);
        }

        public static CrudOperationResult<IEnumerable<Performer>> Get(Criteria criteria)
        {
            return new Performer().FindObject(criteria);
        }
    }


    public class PerformerRepo : SqlServerDal<Performer>
    {
        performer_user toEntity(performer_user e, Performer o)
        {
            e.id = o.Key;
            e.age = o.Age;
            e.nationality = o.Nationality;
            e.lastName = o.LastName;
            e.firstName = o.FirstName;


            return e;
        }

        performer_user toEntity(Performer o)
        {
            return toEntity(new performer_user(), o);
        }

        Performer fromEntity(performer_user e)
        {
            Performer res = new Performer
            {
                Id = e.id,
                FirstName = e.firstName,
                LastName = e.lastName,
                Nationality = e.nationality,
                Age = e.age
            };
            return res;
        }

        public override CrudOperationResult<Performer> CreateObject(Performer obj)
        {
            var res = new CrudOperationResult<Performer>();
            res.Data = obj;
            res.Message = "Could not Create a performer user profile at the moment!";
            res.IsSuccess = false;
            try
            {
                //check existence
                if (IsFound(obj))
                {
                    res.Message = $"A Performer profile with the id : ( {obj.Key} ) already exist";
                }

                var e = toEntity(obj);
                db.performer_user.Add(e);
                Save();
                res.IsSuccess = true;
                res.Message = "Record Saved successfully";
            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "An Internal server error has occurred!";
            }


            return res;
        }

        public override bool IsFound(Performer obj)
        {
            return db.performer_user.Any(x => x.id == obj.Key);
        }

        public override CrudOperationResult<Performer> UpdateObject(Performer obj)
        {
            var res = new CrudOperationResult<Performer>();
            res.Data = obj;
            res.Message = "Could not Update a performer user profile at the moment!";
            res.IsSuccess = false;
            try
            {
                var e = db.performer_user.FirstOrDefault(x => x.id == obj.Key);
                if (e != null)
                {
                    toEntity(e, obj);
                    Save();
                    res.IsSuccess = true;
                    res.Message = "Record Saved successfully";
                }
            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "An Internal server error has occurred!";
            }


            return res;
        }

        public override CrudOperationResult<Performer> DeleteObject(Performer obj)
        {
            var res = new CrudOperationResult<Performer>();
            res.Data = obj;
            res.Message = "Could not Delete a performer user profile at the moment!";
            res.IsSuccess = false;
            try
            {
                var e = db.performer_user.FirstOrDefault(x => x.id == obj.Key);
                if (e != null)
                {
                    db.performer_user.Remove(e);
                    Save();
                    res.IsSuccess = true;
                    res.Message = "Record Deleted successfully";
                }
            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "An Internal server error has occurred!";
            }


            return res;
        }

        public override CrudOperationResult<Performer> FindObject(object id)
        {
            var res = new CrudOperationResult<Performer>();
            Performer p = new Performer() {Id = id};
            res.Message = "Could not Load a performer user profile at the moment!";
            res.IsSuccess = false;
            try
            {
                //check existence
                var e = db.performer_user.FirstOrDefault(x => x.id == p.Key);
                if (e != null)
                {
                    res.Data = fromEntity(e);
                    res.IsSuccess = true;
                    res.Message = "Record Saved successfully";
                }
            }
            catch (Exception err)
            {
                res.ServerException = err;
                res.Message = "An Internal server error has occurred!";
            }


            return res;
        }

        public override CrudOperationResult<IEnumerable<Performer>> FindObject(Criteria criteria)
        {
            var res = new CrudOperationResult<IEnumerable<Performer>>();
            res.IsSuccess = true;
            res.Message = "All record loaded";
            res.Data = db.performer_user.OrderBy(x => x.firstName)
                .Select(fromEntity).ToList();
            return res;
        }
    }
}