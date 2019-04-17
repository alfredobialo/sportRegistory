(function (ng) {

    var sportApp = ng.module("sportsModule", []);
    sportApp
        .controller("ScoreDashboardController", ["$scope", "SportService", ScoreDashboardControllerFunc])
        .controller("PerformerController", ["$scope", "SportService", PerformerControllerFunc])
        .directive("asomAppInfo", [AppInfoFunc])
        .factory("SportService", ["$http", SportServiceFunc])
    ;

    function AppInfoFunc() {
        return {
            scope: {},
            controller: "ScoreDashboardController",
            template: "<div>\n    <h3 class=\'text-danger\'>Application Info</h3>\n    <code>\n        {{crud | json}}\n    </code>\n    \n</div>"
        }
    }

    function PerformerControllerFunc(scope, SportService) {
        scope.loading = false;
        scope.performer = {
            firstName: "Alfred",
            lastName: "Obialo",
            nationality: "Nigeria",
            age: 20
        };
        Toast.debug(scope.performer);
        scope.save = createPerformer;

        function createPerformer(performer) {
            scope.loading = true;
            // check if in valid state
            SportService.createPerformer(performer)
                .then(function (response) {
                    Toast.debug(response.data);
                    if (response.data.success) {
                        // Success info
                    } else {
                        Toast.pullDown(response.data.message, true, 4000, "bg-danger");
                    }
                    scope.loading = false;
                });
        }

    }

    function ScoreDashboardControllerFunc(scope, SportService) {
        scope.crud = {};
        init();

        function init() {
            // call the service
            SportService.getAppInfo()
                .then(function (response) {
                    console.log(response.data);
                    scope.crud = response.data;
                })
        }
    }

    // service func
    function SportServiceFunc($http) {
        var url = effectiv.urls.sports;
        return {
            getAppInfo: function () {
                return $http.get(url, {params: {key: 1}});
            },
            createPerformer: function (model) {
                model = ng.toJson(model);
                return $http.post(url, {key: 10, data: model});

            },
            updatePerformer: function (model) {
                model = ng.toJson(model);
                return $http.post(url, {key: 20, data: model});

            },
            getPerformer: function (id) {
                return $http.get(url, {params: {key: 30, data: id}});
            },
            getPerformers: function (criteria) {
                return $http.get(url, {params: {key: 30, criteria: ng.toJson(criteria)}});
            },

            deletePerformer: function (model) {
                model = ng.toJson(model);
                return $http.post(url, {key: 50, data: model});

            },


        }
    }


})(angular);
