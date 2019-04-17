using System.Web.Mvc;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using itrex.businessObjects.model.core.util;

namespace asom.apps.web.inOut.Controllers
{
    public class UtilController : BaseController
    {
        
        // GET: Util
        public ActionResult GetUrl(int? key , string data, string criteria)
        {
            switch (key)
            {
                case 1: // States
                    return getStates();
                   
                case 2: // Countries
                 return getCountries();
             
                case 3: 
                    return getLgaByState(data);
                case 4:
                    double amount;
                    bool parsed = double.TryParse(data, out amount);
                    return parsed ? getAmountInWord(amount)  : FailedAction("Not a valid number");
            }
           return FailedAction("Wrong Parameter assigned for the query: Key " + key);
        }

        protected ActionResult getStates()
        {
            var states = StateToLgaMapper.GetStates;
            return SuccessAction("States in Nigeria", states);

        }
        protected ActionResult getLgaByState(string state)
        {
            if (!string.IsNullOrEmpty(state))
            {
                state = state.ToLower();
            var lga =StateToLgaMapper.GetLgaByState(state);
            return SuccessAction("LGA in " + state.ToUpper(), lga);
            }
            
            return FailedAction("Input Not valid");
        }
        protected ActionResult getCountries()
        {
            var countries = StateToLgaMapper.GetListOfCounties;
            return SuccessAction("Countries of the world", countries);

        }

        protected ActionResult getAmountInWord(double amount, string currencyName="")
        {
            string currency = currencyName;
            if (string.IsNullOrEmpty(currency))
            {
                // Use Org Currency name Setting
                currency  = OrganizationInfo.GetSettings().CurrencyName;
                
            }
           var res  = NumericCurrency.ConvertCurrencyValueToWord(amount,currency, "kobo") ;
            return SuccessAction("Amount In Word", res);

        }
    }
}