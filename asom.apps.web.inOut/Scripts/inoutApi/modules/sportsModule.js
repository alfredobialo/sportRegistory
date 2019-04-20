(function (ng) {

    var sportApp = ng.module("sportsModule", []);
    sportApp
        .controller("ScoreDashboardController", ["$scope", "SportService", ScoreDashboardControllerFunc])
        .controller("PerformerController", ["$scope", "SportService", PerformerControllerFunc])
        .controller("JudgeScoreBoardController", ["$rootScope","$scope","SportService", JudgeScoreBoardControllerFunc])
        .directive("asomAppInfo", [AppInfoFunc])
        .directive("asomJudgeScoreBoard", [JudegScoreBoardDirectiveFunc])
        .directive("asomPerformerSelector",[PerformerSelectorDirectiveFunc])
        .factory("SportService", ["$http", SportServiceFunc])
    ;

    function AppInfoFunc() {
        return {
            scope: {},
            controller: "ScoreDashboardController",
            template: "<div>\n    <h3 class=\'text-danger\'>Application Info</h3>\n    <code>\n        {{crud | json}}\n    </code>\n    \n</div>"
        }
    }
    function PerformerSelectorDirectiveFunc() {
        function controllerFunc(scope,SportService)
        {
            scope.processing  = false;
            scope.performers  = [];
            // get all Performer Record
            scope.reloadPerformers = getAllPerformers;
            getAllPerformers();
            function getAllPerformers() {
                scope.processing  = true;
                SportService.getPerformers({id:"performer"})
                    .then(function (response) {
                    console.log(response.data.data);
                    scope.processing  = false;
                    if(response.data.success)
                    {
                        scope.performers  = response.data.data;
                    }
                    else
                    {
                        Toast.pullDown(effectiv.getValidationTemplate(response.data), true, 5000 , "bg-danger");
                        
                    }
                })
            }
        }
        return {
            scope :{
                onSelect : "&",
                performer : "="
            },
            template :"<div class=\'p-3\'>\n    <div class=\'row\'>\n        <div class=\'col-4\'>\n            <label for=\'cboPerformer\'>Select Performer</label>\n        </div>\n        <div class=\'col-8\'>\n            <select name=\'\' ng-model=\'performer\'\n                    class=\'p-2 lead w80\'\n                    ng-options=\'p as p.displayName for p in performers\'\n                    id=\'cboPerformer\'>\n                \n            </select>\n        </div>\n    </div>\n</div>",
            controller : ["$scope","SportService",controllerFunc]
        }
    }
    function JudgeScoreBoardControllerFunc(rootScope,scope, SportService) {
        
        scope.currentUser = rootScope.currentUser;
        scope.sb = {
          scoreTechnical : 0.00,
          scoreAthlete : 0.00
           
        };
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
            template : "<div class=\'p-3 bg-white shadow-sm\'>\n    <div class=\'row\'>\n        <div class=\'col-12 col-md-6\'>\n            <div class=\'mb-2\'>\n                <p class=\'lead\'>{{currentUser.id | uppercase}}</p>\n            </div>\n            <div>\n                \n                <div class=\'row\'>\n                    <div class=\'col-8\'><span class=\'text-primary\'>Performer:</span> &nbsp; {{performer.displayName}}</div>\n                    <div class=\'col-4\'>{{performer.nationality | uppercase}}</div>\n                </div>\n            </div>\n            <div class=\'mt-5\'>\n                <div class=\'row\'>\n                    <div class=\'col-5\'>\n                        <label for=\'txtScore\' class=\'text-primary bold lead\'>Technical</label>\n                    </div>\n                    <div class=\'col-8\'><input id=\'txtScore\' type=\'number\' class=\' \'\n                                              style=\'font-size:38px;color:#2344b1; font-weight: bold; border-radius: 13px; \n                                              width: 190px;border:solid 4px #5aa4fc;padding:20px 25px\'\n                                              ng-model=\'sb.scoreTechnical\'></div>\n                </div>\n            </div>\n        </div>\n        <div class=\'col-md-6 col-12\'>\n            <div class=\'d-flex flex-column justify-content-end align-items-end\'>\n               \n                <div class=\'mb-2\'>\n                    <span class=\'lead bold\'>{{groupId | uppercase}}</span>\n                    <!--<input type=\'text\' ng-model=\'groupId\' class=\'p-2 lead\'>-->\n                </div>\n                <div class=\'\'>\n              \n                <div class=\'row\'>\n                    <div class=\'col-8\'><span class=\'text-success\'>Judge Name:</span> &nbsp;  {{currentUser.displayName}}</div>\n                    \n                </div>\n                    <div class=\'mt-5\'>\n                        <div class=\'row\'>\n                            <div class=\'col-5\'>\n                                <label for=\'txtScore2\' class=\'text-success bold lead\'>Athletic</label>\n                            </div>\n                            <div class=\'col-8\'><input id=\'txtScore2\' type=\'number\' class=\' \'\n                                                      style=\'font-size:38px; color:#41b131; font-weight: bold; border-radius: 13px; \n                                                  width: 190px;border:solid 4px #64fc78;padding:20px 25px\'\n                                                      ng-model=\'sb.scoreAthlete\'></div>\n                        </div>\n                    </div>\n                    \n            </div>\n            </div>\n        </div>\n    </div>\n    <div class=\'p-3 mt-3 bg-danger text-center \' ng-hide=\'performer\'><span class=\'lead text-white\'>Please Select a Performer</span></div>\n    <div class=\'mt-4 p-3 d-flex flex-row justify-content-center align-items-center\' ng-show=\'performer\'>\n        <button class=\'btn btn-light btn-lg\'>Cancel</button>\n        <button class=\'btn btn-primary btn-lg\'>Save Score</button>\n    </div>\n</div>",
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
