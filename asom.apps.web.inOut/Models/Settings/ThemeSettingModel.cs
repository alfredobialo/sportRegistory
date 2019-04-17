using System.Collections.Generic;
using System.Linq;
using System.Web;
using asom.apps.inOut.core.model.org;
using asom.apps.web.inOut.Controllers.BaseControllers;
using Newtonsoft.Json;

namespace asom.apps.web.inOut.Models.Settings
{
    public class Themes
    {
        
        private string thumbnail;
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("url")]
        public string Url { get; set; }

        [JsonProperty("thumbnail")]
        public string Thumbnail
        {
            get { return MyConfig.GenerateUrlWithDomainName(thumbnail); }
            set
            {
                thumbnail = value;
            }
        }
    }
    public class ThemeSetting
    {
        public static IEnumerable<Themes> GetAvailableThemes()
        {
            var allThemes = new List<Themes>()
            {
                new Themes()
                {
                    Name = "Oliv",
                    Url = "oliv/theme-oliv.css",
                    Thumbnail = "images/themes_thumbnail/oliv.png"

                },
                new Themes()
                {
                    Name = "Iyki",
                    Url = "iyki/theme-iyki.css",
                    Thumbnail = "images/themes_thumbnail/iyki.png"


                },
                new Themes()
                {
                    Name = "Pumkn",
                    Url = "pumkn/theme-pumkn.css",
                    Thumbnail =
                        "images/themes_thumbnail/pumkn.png"
                },
                new Themes()
                {
                    Name = "Ox-Blud",
                    Url = "ox-blud/theme-ox-blud.css",
                    Thumbnail =
                        "images/themes_thumbnail/ox-blud.png"
                },
                new Themes()
                {
                    Name = "Darkn",
                    Url = "Darkn/theme-darkn.css",
                    Thumbnail =
                        "images/themes_thumbnail/darkn.png"
                },
                new Themes()
                {
                    Name = "Skoologic",
                    Url = "skoologic/theme-skoologic.css",
                    Thumbnail =
                        "images/themes_thumbnail/skoologic.png"
                },
                new Themes()
                {
                    Name = "Def",
                    Url = "def/theme-def.css",
                    Thumbnail =
                        "images/themes_thumbnail/def.png"
                },
                new Themes()
                {
                    Name = "Slide",
                    Url = "slide/theme-slide.css",
                    Thumbnail =
                        "images/themes_thumbnail/slide.png"
                },
                new Themes()
                {
                    Name = "Opioro",
                    Url = "opioro/theme-opioro.css",
                    Thumbnail =
                        "images/themes_thumbnail/opioro.png"
                },
                new Themes()
                {
                    Name = "Udara",
                    Url = "udara/theme-udara.css",
                    Thumbnail =
                        "images/themes_thumbnail/udara.png"
                },
                new Themes()
                {
                    Name = "Green House",
                    Url = "greenhouse/theme-greenhouse.css",
                    Thumbnail =
                        "images/themes_thumbnail/greenhouse.png"
                },
                new Themes()
                {
                    Name = "Coalbat",
                    Url = "coalbat/theme-coalbat.css",
                    Thumbnail =
                        "images/themes_thumbnail/coalbat.png"
                },
                new Themes()
                {
                    Name = "Asom",
                    Url = "asom/theme-asom.css",
                    Thumbnail =
                        "images/themes_thumbnail/asom.png"
                },
                new Themes()
                {
                    Name = "Magnum",
                    Url = "magnum/theme-magnum.css",
                    Thumbnail =
                        "images/themes_thumbnail/magnum.png"
                },
                new Themes()
                {
                    Name = "Effectiv",
                    Url = "effectiv/theme-effectiv.css",
                    Thumbnail =
                        "images/themes_thumbnail/effectiv.png"
                },
                new Themes()
                {
                    Name = "Halo",
                    Url = "halo/theme-halo.css",
                    Thumbnail =
                        "images/themes_thumbnail/halo.png"
                },
                new Themes()
                {
                    Name = "Biafra",
                    Url = "biafra/theme-biafra.css",
                    Thumbnail =
                        "images/themes_thumbnail/biafra.png"
                },
                new Themes()
                {
                    Name = "Daylight",
                    Url = "daylight/theme-daylight.css",
                    Thumbnail =
                        "images/themes_thumbnail/daylight.png"
                },
                new Themes()
                {
                    Name = "Moonlight",
                    Url = "moonlight/theme-moonlight.css",
                    Thumbnail =
                        "images/themes_thumbnail/moonlight.png"
                },
                new Themes()
                {
                    Name = "Libration",
                    Url = "libration/theme-libration.css",
                    Thumbnail =
                        "images/themes_thumbnail/libration.png"
                },
                new Themes()
                {
                    Name = "NDCreek",
                    Url = "ndcreek/theme-ndcreek.css",
                    Thumbnail =
                        "images/themes_thumbnail/ndcreek.png"
                },
                new Themes()
                {
                    Name = "Facebook",
                    Url = "fb/theme-fb.css",
                    Thumbnail =
                        "images/themes_thumbnail/facebook.png"
                },
                new Themes()
                {
                    Name = "Twitter",
                    Url = "tw/theme-tw.css",
                    Thumbnail =
                        "images/themes_thumbnail/twitter.png"
                },
                new Themes()
                {
                    Name = "Trademit",
                    Url = "trademit/theme-trademit.css",
                    Thumbnail =
                        "images/themes_thumbnail/trademit.png"
                },
                new Themes()
                {
                    Name = "Duzzy",
                    Url = "duzzy/theme-duzzy.css",
                    Thumbnail =
                        "images/themes_thumbnail/duzzy.png"
                },
                new Themes()
                {
                    Name = "Maroon",
                    Url = "maroon/theme-maroon.css",
                    Thumbnail =
                        "images/themes_thumbnail/maroon.png"
                },
                new Themes()
                {
                    Name = "Coder",
                    Url = "codes/theme-codes.css",
                    Thumbnail =
                        "images/themes_thumbnail/codes.png"
                }
            };

            return allThemes;//.OrderBy(x=>x.Name);
        }

        public static Themes GetDefault()
        {
             return GetAvailableThemes().FirstOrDefault(x => x.Name == OrganizationInfo.GetSettings().AppThemeName);
            HttpContext ctx  =  HttpContext.Current;
            var theme = (ctx.Session["theme"] as Themes);
            if (theme == null)
            {
                return GetAvailableThemes().FirstOrDefault(x => x.Name == OrganizationInfo.GetSettings().AppThemeName);
                // res = JsonConvert.SerializeObject(, MyConfig.DefaultJsonSettings);
            }
            else
            {
                return theme;
                //res = JsonConvert.SerializeObject(theme, MyConfig.DefaultJsonSettings);
            }

        }
        public static string GetAvailableThemesAsJSON()
        {
            var allThemes = GetAvailableThemes();
            string data = JsonConvert.SerializeObject(allThemes, MyConfig.DefaultJsonSettings);
            

            return data;
        }
    }

    public class InvoiceTemplate
    {
        public string  Name { get; set; }
        public string ImageUrl { get; set; }
        public string FileName { get; set; }
        public string Id { get; set; }
        public bool IsActive { get; set; }

        public static ServerResponseModel GetInvoiceTemplates()
        {
            string basePath = "images/invoice_report_template/template?.jpg";
            
            ServerResponseModel res =  new ServerResponseModel();
            res.Message = "Invoice Template loaded!";
            res.Success = true;
            
            var result =   new List<InvoiceTemplate>()
            {
                new InvoiceTemplate() {
                    Name ="Template1" ,
                    FileName  = "invoice_template1",
                    Id =  "1",
                    IsActive = false,
                    ImageUrl = MyConfig.GenerateUrlWithDomainName(basePath.Replace("?","1"))
                },
                new InvoiceTemplate() {
                    Name ="Template2" ,
                    FileName  = "invoice_template2",
                    Id =  "2",
                    IsActive = false,
                    ImageUrl = MyConfig.GenerateUrlWithDomainName(basePath.Replace("?","2"))
                },
                 new InvoiceTemplate() {
                    Name ="Template3" ,
                    FileName  = "invoice_template3",
                    Id =  "3",
                    IsActive = false,
                    ImageUrl = MyConfig.GenerateUrlWithDomainName(basePath.Replace("?","3"))
                },
                new InvoiceTemplate() {
                    Name ="Template4" ,
                    FileName  = "invoice_template4",
                    Id =  "4",
                    IsActive = false,
                    ImageUrl = MyConfig.GenerateUrlWithDomainName(basePath.Replace("?","4"))
                },
            };
            res.Data = result;
            return res; 
        } 
    }
}