using asom.apps.web.inOut;
using Microsoft.AspNet.SignalR;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(Startup))]

namespace asom.apps.web.inOut
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            
            HubConfiguration hubConfig  =  new HubConfiguration()
            {
                EnableJSONP = true,
                
            };
            app.MapSignalR();
          
        }
    }
}
