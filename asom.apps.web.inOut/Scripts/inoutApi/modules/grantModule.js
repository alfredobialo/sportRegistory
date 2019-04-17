(function(ng, window)
{
    var grantModule  = ng.module("grantModule", [])
        .factory("GrantService",["$http", GrantServiceFunction])
        .directive ("asomGrantRegister", [GrantRegisterDirectiveFunc])    
    
    ;
        
        function GrantRegisterDirectiveFunc() {
            
            function controlFunc(scope, GrantService) {
                scope.grants  = GrantService.getGrants("School Grant");
            }
            return {
                template : "<div>\n    <p class=\'lead\'>{{title}}</p>\n    <div class=\'row\'>\n        <div class=\'col-sm-3\'>\n            <p class=\'p-3 m-3\' ng-repeat=\'g in grants\'>{{g}}</p>\n            \n            \n        </div>\n        <div class=\'col-sm-9\'>\n            <h1 ng-if=\'currentUser\'>\n                {{currentUser.displayName}}\n            </h1>\n            <img ng-src=\'{{currentUser.pictureUrl}}\' class=\'img-responsive\'\n                 width=\'300px\'\n        </div>\n\n    </div>\n\n</div>\n",
                scope : {
                    currentUser  : "=",
                    title : "@"
                },
                controller : ["$scope","GrantService", controlFunc]
                
            };
        }
    
        function GrantServiceFunction($http) {
            return {
                getGrants  : function (criteria) {
                    return ["Hello", "Available Grants",criteria];
                }
            }
        }
    
})(angular, window);