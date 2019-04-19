(function (ng) {

    var sportApp = ng.module("sportsModule", []);
    sportApp
        .controller("ScoreDashboardController", ["$scope", "SportService", ScoreDashboardControllerFunc])
        .controller("PerformerController", ["$scope", "SportService", PerformerControllerFunc])
        .controller("JudgeScoreBoardController", ["$rootScope","$scope","SportService", JudgeScoreBoardControllerFunc])
        .directive("asomAppInfo", [AppInfoFunc])
        .directive("asomJudgeScoreBoard", [JudegScoreBoardDirectiveFunc])
        .factory("SportService", ["$http", SportServiceFunc])
    ;

    function AppInfoFunc() {
        return {
            scope: {},
            controller: "ScoreDashboardController",
            template: "<div>\n    <h3 class=\'text-danger\'>Application Info</h3>\n    <code>\n        {{crud | json}}\n    </code>\n    \n</div>"
        }
    }
    
    function JudgeScoreBoardControllerFunc(rootScope,scope, SportService) {
        
        scope.currentUser = rootScope.currentUser;
        function init(msg) {
           
        }
        init("You've made changes to the score for the selected performer, do you want save the current entry?");
        
    }
    
    function JudegScoreBoardDirectiveFunc() {
        return  {
            scope : {
                groupId : "@",
                performer : "="
                
            },
            template : "<div class=\'p-3 bg-white shadow-sm\'>\n    <div class=\'row\'>\n        <div class=\'col-6\'>\n            <div class=\'mb-2\'>\n                <p class=\'lead\'>{{currentUser.id | uppercase}}</p>\n            </div>\n            <div>\n                <div class=\'row\'>\n                    <div class=\'col-8\'>{{performer.fullName}}</div>\n                    <div class=\'col-4\'></div>\n                </div>\n            </div>\n        </div>\n        <div class=\'col-6\'>\n            <div>\n                <p class=\'lead bold\'>{{groupId | uppercase}}</p>\n            </div>\n        </div>\n    </div>\n</div>",
            controller  :"JudgeScoreBoardController",
            
        }
        
    }

    function PerformerControllerFunc(scope, SportService) {
        scope.loading = false; 
        scope.performers = [];
        scope.performer = {
            firstName: null,
            lastName: null,
            nationality: "Nigeria",
            age: 20
        };
       
        scope.save = createPerformer;
        scope.delete = delPerformer;
        scope.criteria = {
          id : "load-performers"  
        };

        loadPerformers();
        function delPerformer(performer)
        {
            SportService.deletePerformer(performer.id)
                .then(function (response) {
                    if (response.data.success) {
                        // Success info
                        Toast.pullDown(response.data.message);
                        scope.performers.splice(_.indexOf(scope.performers, function(obj) { return obj.id === performer.id}), 1);
                    } else {
                        Toast.pullDown(response.data.message, true, 4000, "bg-danger");
                    }
                    
                });
        }
        function loadPerformers() {
            scope.loading  = true;
            SportService.getPerformers(scope.criteria)
                .then(function (response) {
                   
                    scope.performers = response.data.data;
                })
        }
        function createPerformer(performer) {
            scope.loading = true;
            // check if in valid state
            SportService.createPerformer(performer)
                .then(function (response) {
                 
                    if (response.data.success) {
                        // Success info
                   Toast.pullDown(response.data.message);
                   scope.performer.firstName  = null;
                   scope.performer.lastName  = null;
                        scope.performers.push(response.data.data);
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
                return $http.get(url, {params: {key: 40, criteria: ng.toJson(criteria)}});
            },

            deletePerformer: function (model) {
               
                return $http.post(url, {key: 50, data: model});

            },


        }
    }


})(angular);
