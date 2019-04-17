/**
 * Created by USER on 4/11/2016.
 */
(function(ng, window){

    ng.module("signalrModule", [])
        .factory("HubConnectionService", [HubConnectionService]);

    function HubConnectionService()
    {
        return {
            getThemesHubConnection  : function()
            {
                var themescon  = {
                        themeHub : $.connection.themesHub,
                        connection : $.connection.hub
                    };

                return themescon;
            },
            getHrHubConnection  : function()
            {
                var hr  = {
                    hr : $.connection.hrHub,
                    connection : $.connection.hub
                };

                return hr;
            },
        }
    }

})(angular, window);