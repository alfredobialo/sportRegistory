using System.Threading.Tasks;
using asom.apps.web.inOut.Models.Settings;
using Microsoft.AspNet.SignalR;

namespace asom.apps.web.inOut.Hubs
{
    public class ThemesHub : Hub
    {
        
        public void NotifyThemeChanged(Themes themeInfo)
        {
            var theme = ThemeSetting.GetDefault();
            Clients.Others.themeChanged( theme);
        }

        public override Task OnConnected()
        {
//            Debug.Print(this.Context.ConnectionId + " User" +Context.User.Identity.Name); 
            return base.OnConnected();
        }
    }
}