using Microsoft.AspNet.SignalR;

namespace asom.apps.web.inOut.Hubs
{
    public class AlertHub : Hub
    {
        public void Hello()
        {
            Clients.All.hello();
        }
    }
}