(function(ng, win) {

    ng.module("menuModule", [])
        .controller("MenuController", ["$scope", "MenuManagerService", MenuController])
        .factory("MenuManagerService", ["$http", MenuManagerService]);
    function MenuManagerService($http) {
        return {
            getMenus: function(getActive) {
                return $http.get(effectiv.urls.menuUrl, { params: { getactive: getActive } });
            }
        };
    }

    function MenuController(scope,  MenuManagerService) {

        scope.menus = [];
        scope.getActive = false;
        scope.serverResult = {};
        scope.getMenu = function() {
            MenuManagerService.getMenus(scope.getActive)
                .then(function(response) {
                    //alert("response from server");
                    scope.serverResult = response.data;

                    scope.menus = angular.fromJson(response.data.data);
                    //(scope.menus);
                }, function(xhr) {
                    //(xhr);
                });
        }
        scope.popOutMenu=function(elemRef)
        {

            Toast.slideOutMenu(elemRef);
      };
      scope.closeMenu =function(elemRef)
      {

        Toast.slideInMenu(elemRef);
      };
    }

    function ToastService()
    {

    }

})(angular, window);
