using System;
using System.Collections.Generic;
using System.Linq;
using asom.apps.inOut.core.dal.sqlserver;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.securables;

namespace asom.apps.inOut.core.model.org
{
    public class CurrencyConversion  :  DefaultPersistable<CurrencyConversion>
    {
        public ICurrency Currency { get; set; }
        public ICurrency DefaultCurrency { get; set; }  // DEFAULT IS NIGERIAN NAIRA
        public decimal Value { get; set; }  // Value for the default currency in respect to the currency. eg 1 dollar ===  320 Naira, value is 320

        public bool IsActive
        {
            get { return this.IsOn ?? false; }
            set { IsOn = value; }

            
        } // if this the selected currency conversion logic
        public override DefRepository<CurrencyConversion> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<CurrencyConversion>.DataSource ?? new CCRepo();
        }

        public CurrencyConversion()
        {
            DefaultCurrency   = CurrencyType.NIGERIAN_NAIRA;
        }


/*
        EXAMPLE OF A CONVERTER TABLE
        ------------------|--------------------------------
            $1             =>   318 DEFAULT VALUE
            £1             =>   510 DEFAULT VALUE
            NGR 1          =>   1 default value  // Naira is also the default
        ----------------------------------------------------

        which means if we have a product like :

            1bag of Dangote Cement : 1200, we assumes is in Nigerian naira, because thats the default
            and our conversion table operating currency has not been selected

*/

        public static CurrencyConversion GetCurrency(string id)
        {
            return new CurrencyConversion().Find(id);
        }
        public static IEnumerable<CurrencyConversion> GetCurrencies()
        {
            return new CurrencyConversion().Find(new Criteria());
        }

        public static CurrencyConversion GetDefaultCurrency()
        {
            return new CurrencyConversion().Find(new ObjSearchCriteria() {FindByObj = true})
                .FirstOrDefault();
        }
    }

    public class CurrencyManager
    {
        public static CurrencyConversion GetDefaultCurrency()
        {
            return  CurrencyConversion.GetDefaultCurrency();

        }
        static IEnumerable<CurrencyConversion> currecies  = new  List<CurrencyConversion>();

//        static CurrencyManager()
//        {
//            currecies = CurrencyConversion.GetCurrencies();
//        }

        public static IEnumerable<CurrencyConversion> Currencies
        {
            get
            {
                return CurrencyConversion.GetCurrencies();
                
            }
            internal set { currecies = value; }
        }

        public static decimal Convert(decimal amount, CurrencyConversion preferedConverter)
        {
            decimal res = 0.00m;
/*
        if 1Ngr  = 1Ngr
            2000ngr = 2000/1
            ________________________

            if 320 ngr  = $1
                2000 ngr  = 2000 * 1/ 320

*/
            res  = Math.Round(amount / preferedConverter.Value,2, MidpointRounding.AwayFromZero);
            return res;
        }
    }

    public interface ICurrency
    {
        string CurrencyName { get; set; }
        string CurrencySymbol { get; set; }
        string CurrencyAbbrv { get; set; }
        string Country { get; set; }
    }

    public class CurrencyType : DefaultPersistable<CurrencyType>, ICurrency
    {
        public static ICurrency NIGERIAN_NAIRA  = new CurrencyType()
        {
            Country = "Nigeria",
            CurrencyAbbrv = "NGR",
            CurrencySymbol = OrgAppSetting.NAIRA,
            CurrencyName = "Naira"
        };
        public static ICurrency US_DOLLAR = new CurrencyType()
        {
            Country = "USA",
            CurrencyAbbrv = "$",
            CurrencySymbol = "$",
            CurrencyName = "US Dollar"
        };
        public static ICurrency BRITISH_POUND = new CurrencyType()
        {
            Country = "Britain",
            CurrencyAbbrv = "£",
            CurrencySymbol = "£",
            CurrencyName = "British Pound"
        };
        public static ICurrency BIAFRAN_POUND = new CurrencyType()
        {
            Country = "Biafra",
            CurrencyAbbrv = "Br",
            CurrencySymbol = "Br",
            CurrencyName = "Biafra Pound"
        };
        public static readonly List<string> currencyName  =  new List<string>()
        {
            "British Pound", "Biafra Pound", "US Dollar","Naira"
        }; 
       public static readonly List<ICurrency> DEFAULT_CURRENCIES  =  new List<ICurrency>()
        {
           BIAFRAN_POUND,BRITISH_POUND, NIGERIAN_NAIRA, US_DOLLAR
        };

        public string CurrencyName
        {
            get { return Key; }
            set {Key =  value;}
        }

        public string CurrencySymbol { get; set; }
        public string CurrencyAbbrv { get; set; }
        public string Country { get; set; }

        public override DefRepository<CurrencyType> GetDefaultDataSource()
        {
            return ObjDataSourceFactory<CurrencyType>.DataSource ??  new CurrencyTypeRepo();
        }

        public override IValidationError Validate()
        {
            bool nameValid = !string.IsNullOrEmpty(CurrencyName);
            ValidationErrorLog errors  =  new ValidationErrorLog();
            if (!nameValid) errors.AddError("Currency Name", "Currency Name required");
            return errors;
        }

        // add new Currency
    }

    public class CurrencyTypeRepo : SqlServerDal<CurrencyType>
    {
//        public override bool IsFound(CurrencyType obj)
//        {
//            foreach (var c in CurrencyType.DEFAULT_CURRENCIES)
//            {
//                bool exist = c.CurrencyName.ToLower() == obj.CurrencyName.ToLower();
//                return exist;
//            }
//
//            return db.currency_policy.Any(x => x.currency == obj.Key);
//        }
        public override CrudOperationResult<IEnumerable<CurrencyType>> FindObject(Criteria criteria)
        {
            CrudOperationResult<IEnumerable<CurrencyType>> res = new CrudOperationResult<IEnumerable<CurrencyType>>();
            res.Data = new List<CurrencyType>();
            res.IsSuccess = false;

            try
            {
                //              

                res.IsSuccess = true;
                
                res.Data = CurrencyType.DEFAULT_CURRENCIES.Select(x => (CurrencyType)x).ToList();
                res.Message = "All Currency Convertions retrived";
              
                // if we have storage types defined, create them as well

            }
            catch (UnAuthorizeException err)
            {

                res.Message = "You are Not authorized to create inventory items";
                res.ServerException = err;
            }
            catch (Exception err)
            {

                res.HasException = true;
                res.Message = "Internal Data Server Error";
                res.ServerException = err;

            }

            return res;

        }
    }

    public class CCRepo : SqlServerDal<CurrencyConversion>
    {
        public override CrudOperationResult<IEnumerable<CurrencyConversion>> FindObject(Criteria criteria)
        {
            CrudOperationResult<IEnumerable<CurrencyConversion>> res  =  new CrudOperationResult<IEnumerable<CurrencyConversion>>();
            res.Data = new List<CurrencyConversion>();
            res.IsSuccess = false;

            try
            {
//              
               
                res.IsSuccess = true;
                var cc  = new List<CurrencyConversion>();
                cc.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.NIGERIAN_NAIRA,
                            Value = 1,
                            IsActive = false,
                        }

                    );
                cc.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.US_DOLLAR,
                            Value = 340,
                            IsActive = true,
                        }

                    );
                cc.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.BRITISH_POUND,
                            Value = 499,
                            IsActive = false,
                        }

                    );
                cc.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.BIAFRAN_POUND,
                            Value = 112,
                            IsActive = false,
                        }

                    );
                res.Data = cc;
                res.Message = "All Currency Convertions retrived";
                res.IsSuccess = true;
                // if we have storage types defined, create them as well

            }
            catch (UnAuthorizeException err)
            {
                
                res.Message = "You are Not authorized to create inventory items";
                res.ServerException = err;
            }
            catch (Exception err)
            {
                
                res.HasException = true;
                res.Message = "Internal Data Server Error";
                res.ServerException = err;
               
            }
           
            return res;
            
        }

        public override IEnumerable<CurrencyConversion> Get(Criteria criteria)
        {
            List<CurrencyConversion> res = new List<CurrencyConversion>();
            if (criteria != null)
            {
                // Just return the default currency as Naira for testing
                // subsequently, we would test for other DEFAULT_CURRENCIES
                CurrencyConversion cc = new CurrencyConversion();
                cc.Currency = CurrencyType.NIGERIAN_NAIRA;
                cc.IsActive = true;
                cc.Value = (1m/332m); // this the value to the default = 1 Naira is equivalent to 1 Naira
                res.Add(cc);
            }
            else
            {
                res.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.NIGERIAN_NAIRA,
                            Value = 1,
                            IsActive = false,
                        }

                    );
                res.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.US_DOLLAR,
                            Value = 320,
                            IsActive = true,
                        }

                    );
                res.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.BIAFRAN_POUND,
                            Value = 490,
                            IsActive = false,
                        }

                    );
                res.Add(
                        new CurrencyConversion()
                        {
                            Currency = CurrencyType.BIAFRAN_POUND,
                            Value = 112,
                            IsActive = false,
                        }

                    );

            }
            return res;

        }
    }
}
