using Microsoft.AspNet.SignalR;

namespace asom.apps.web.inOut.Hubs
{
    /// <summary>
    /// Handles Real time notifications for the Human Resource Management Module for Effective
    /// </summary>
    public class HrHub : Hub
    {
        /// <summary>
        /// Notifies us when a new Employee record has be added
        /// </summary>
        public void NotifyNewEmployee( dynamic serverResponse)
        {
            // this should be called only if the user has access to certain permissions
            // we have to restric access of 
            Clients.All.updateEmployeeList( serverResponse);
        }
    }
}