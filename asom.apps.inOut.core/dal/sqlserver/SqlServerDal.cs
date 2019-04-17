using System.Data.Entity;
using asom.apps.inOut.core.dal.sqlserver.db;
using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal.sqlserver
{
    public abstract  class SqlServerDal<T>  : DefaultDal<T>
    {
        //protected EffectivDataModel db;
        protected Db db;
        protected internal SqlServerDal()
        {
            if (string.IsNullOrEmpty(AppConfig.ConnectionString))
            {
                db = new Db();
                
                    
            }
            else
            {
                 db = new Db(AppConfig.ConnectionString);
                
            }
        }
        
        protected override void Save()
        {
            db.SaveChanges();
            db.Database.Connection.Close();
        }
    }


    public partial class InOutDataModel  : DbContext
    {
        public InOutDataModel(string connectionStringName) 
            : base("name="+ connectionStringName)
        {
           
        }
      
       
    }
    public  class Db  : sports_db
    {
        public Db(string connectionStringName) 
           //"name="+
        {
           Database.Connection.ConnectionString = connectionStringName;
            //check for database connection failure
            this.Configuration.LazyLoadingEnabled = false;
//            this.Configuration.AutoDetectChangesEnabled = false;
        }
//        public effectiv_database() :base("name=effectiv_database") { }
        public Db():base()
        {
            
        }
       
    }
}
