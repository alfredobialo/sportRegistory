using System;
using asom.apps.inOut.core.model.org;

namespace asom.apps.web.inOut.Models.Settings
{

    [Serializable]
    public class CurrencySettingModel
    {
        public string CurrencyName { get; set; } = "Naira";
        public string CurrencySymbol { get; set; } = OrgAppSetting.NAIRA;
        public string CurrencyAbbrv { get; set; } = "NGR";
    }
}