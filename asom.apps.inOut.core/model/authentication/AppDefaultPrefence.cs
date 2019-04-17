using System.Collections.Generic;

namespace asom.apps.inOut.core.model.authentication
{
    public static class AppDefaultPreference
    {
        public static  int PREFERENCE_COUNT  = 5 ;




        public const string USER_THEME_VALUE = "Biafra";
        public const string USER_THEMEE_KEY = "theme";
        ///////////////////////////////////////////////////////////
        public const string BITCOIN_CRITERIA_VALUE = null;
        public const string BITCOIN_CRITERIA_KEY = "bitcoin_criteria";
        /// 
        ///   Inventory Criteria
        public const string BANK_CRITERIA_VALUE = null;
        public const string BANK_CRITERIA_KEY = "bank_criteria";
        ///   Transaction Criteria     
        public const string TRANSACTION_CRITERIA_VALUE = null;
        public const string TRANSACTION_CRITERIA_KEY = "transaction_criteria";
        ///   Dashboard Criteria    
        public const string DASHBOARD_CRITERIA_VALUE = null;
        public const string DASHBOARD_CRITERIA_KEY = "dashboard_criteria";
        
//       ///   Accounting Criteria
//        public const string ACCOUNTING_CRITERIA_VALUE = null;
//        public const string ACCOUNTING_CRITERIA_KEY = "accounting_criteria";
//       /// 
        public const string ITEM_GRID_SORT_VALUE = null;
        public const string ITEM_GRID_SORT_KEY = "item_grid_sort";

        public const string REFERAL_LIST_VALUE = null;
        public const string REFERAL_LIST_KEY = "referal_key";

        ///////////////////////////////////////////////////////////
        //TODO : add Sorting preference for different data grids
        public static IEnumerable<IdentityPreference> DefaultPreferences
        {
            get
            {
                List<IdentityPreference> lst  =  new List<IdentityPreference>();
              

                lst.Add(new IdentityPreference()
                {
                    PrefKey = USER_THEMEE_KEY,
                    PrefValue = USER_THEME_VALUE,
                    DataType = "String"
                });

                lst.Add(new IdentityPreference()
                {
                    PrefKey = BITCOIN_CRITERIA_KEY,
                    PrefValue = BITCOIN_CRITERIA_VALUE,
                    DataType = "String"
                });
                lst.Add(new IdentityPreference()
                {
                    PrefKey = BANK_CRITERIA_KEY,
                    PrefValue = BANK_CRITERIA_VALUE,
                    DataType = "String"
                });
                lst.Add(new IdentityPreference()
                {
                    PrefKey = TRANSACTION_CRITERIA_KEY,
                    PrefValue = TRANSACTION_CRITERIA_VALUE,
                    DataType = "String"
                });
                lst.Add(new IdentityPreference()
                {
                    PrefKey = DASHBOARD_CRITERIA_KEY,
                    PrefValue = DASHBOARD_CRITERIA_VALUE,
                    DataType = "String"
                });
                lst.Add(new IdentityPreference()
                {
                    PrefKey = ITEM_GRID_SORT_KEY,
                    PrefValue = ITEM_GRID_SORT_VALUE,
                    DataType = "String"
                });
                lst.Add(new IdentityPreference()
                {
                    PrefKey = REFERAL_LIST_KEY,
                    PrefValue = REFERAL_LIST_VALUE,
                    DataType = "String"
                });
                PREFERENCE_COUNT = lst.Count;
                return lst;
            }

        } 

    }
}
