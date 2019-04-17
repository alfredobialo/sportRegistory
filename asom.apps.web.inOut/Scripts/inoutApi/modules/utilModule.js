/**
 * Created by USER on 5/4/2016.
 */
// Useful Helper Functions
(function( ng , window){
    angular.module('utilModule', [])
        .factory('NigerianStateService' ,  ['$http', NigerianStateService])
        .factory('NumericTextService' ,  ['$http', NumericTextService]);
    
    function NigerianStateService(http)
    {
        var res  = {
            getStates    : function()
            {
                return http.get(effectiv.urls.appUrl , { params : { key  : 1,module : 'util'}});
            },
            getCountries    : function()
            {
                return http.get(effectiv.urls.appUrl , { params : { key  : 2,module : 'util'}});
            },
            getLgaByState    : function(state)
            {
                return http.get(effectiv.urls.appUrl , { params : { key  : 3, data  : state,module : 'util'}});
            }
        };
        return res;
    }
    function NumericTextService(http)
    {

        var res  = {
            getAmountInWord    : function(amount)
            {
                return http.get(effectiv.urls.appUrl , { params : { key  : 4, data : amount,module : 'util'}});
            },

        };
        return res;
    }
})(angular, window);