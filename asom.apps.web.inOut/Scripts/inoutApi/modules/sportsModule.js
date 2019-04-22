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

        scope.scores  = [];
        scope.processing = false;
        scope.currentUser = rootScope.currentUser;
        scope.sb = {
          scoreTechnical : 5.00,
          scoreAthlete : 5.00
           
        };
        scope.resetBoard  = resetBoard;
        function resetBoard()
        {
            scope.performer  = null;
            scope.sb.scoreAthlete =5.0;
            scope.sb.scoreTechnical =5.0;
        }
        
        function init()
        {
            // Get Scores
            SportService.getJudgeScoreEntry({
                id : scope.groupId })
               .then(function(response){
                   if(response.data.success)
                   {
                       // 
                       scope.scores  = response.data.data;
                   }
                   else{
                       Toast.pullDown(response.data.message,false, 6000, "bg-danger");
                   }
               });
        }
        
        scope.saveScore = saveScoreEntry;
        function saveScoreEntry()
        {
          
            if(confirm("Do you want to save the current scores ?"))
            {
                scope.processing = true;
                scope.sb.groupId =scope.groupId;
                scope.sb.performerId = scope.performer.id;
               SportService.createJudgeScore(scope.sb)
                   .then(function (response) {
                      if(response.data.success)
                      {
                          resetBoard();
                          Toast.pullDown(response.data.message);
                      }
                      else{
                          Toast.pullDown(effectiv.getValidationTemplate(response.data), true, 500, "bg-danger");
                      }
                       scope.processing = false;
                   })
            }
            
           
        }
    }
    
    function JudegScoreBoardDirectiveFunc() {
        return  {
            scope : {
                groupId : "@",
                performer : "=",
                color :"@"
                
            },
            template : "<div class=\'bg-white shadow-sm\'>\n    <div class=\' p-2\' style=\'background-color:{{color}}\'></div>\n    <div class=\'p-3\'>\n        <div class=\'row\'>\n            <div class=\'col-12 col-md-6\'>\n                <div class=\'mb-2\'>\n                    <p class=\'lead\'>{{currentUser.id | uppercase}}</p>\n                </div>\n                <div>\n\n                    <div class=\'row\'>\n                        <div class=\'col-9\'><span class=\'text-primary\'>Performer:</span> &nbsp; {{performer.displayName}}</div>\n                        <div class=\'col-3\'>{{performer.nationality | uppercase}}</div>\n                    </div>\n                </div>\n                <div class=\'mt-5\'>\n                    <div class=\'row\'>\n                        <div class=\'col-5\'>\n                            <label for=\'txtScore\' class=\'text-primary bold lead\'>Technical</label>\n                        </div>\n                        <div class=\'col-8\'><input id=\'txtScore\' type=\'number\' class=\' text-center\'\n                                                  style=\'font-size:38px;color:#2344b1; font-weight: bold; border-radius: 13px; \n                                              width: 190px;border:solid 4px #5aa4fc;padding:20px 25px\'\n                                                  ng-model=\'sb.scoreTechnical\'></div>\n                    </div>\n                </div>\n            </div>\n            <div class=\'col-md-6 col-12\'>\n                <div class=\'d-flex flex-column justify-content-end align-items-end\'>\n\n                    <div class=\'mb-2\'>\n                        <span class=\'lead bold\' style=\'color:{{color}}\'>{{groupId | uppercase}}</span>\n                        <!--<input type=\'text\' ng-model=\'groupId\' class=\'p-2 lead\'>-->\n                    </div>\n                    <div class=\'\'>\n\n                        <div class=\'row\'>\n                            <div class=\'col-12\'><span class=\'text-success\'>Judge Name:</span> &nbsp;  {{currentUser.displayName}}</div>\n\n                        </div> \n                       \n                        <div class=\'mt-5\'>\n                           \n                            <div class=\'row\'>\n                                <div class=\'col-5\'>\n                                    <label for=\'txtScore2\' class=\'text-success bold lead\'>Athletic</label>\n                                </div>\n                                <div class=\'col-8\'>\n                                    <input id=\'txtScore2\' type=\'number\' class=\'text-center \'\n                                           \n                                                          style=\'font-size:38px; color:#41b131; font-weight: bold; border-radius: 13px; \n                                                  width: 190px;border:solid 4px #64fc78;padding:20px 25px\'\n                                                          ng-model=\'sb.scoreAthlete\'></div>\n                            </div>\n                        </div>\n\n                    </div>\n                </div>\n            </div>\n        </div>\n        <div class=\'p-2 mt-2 mb-2\' ng-if=\'processing\'>\n            <span class=\'font-size-38\'>Processing....<i class=\'fa-refresh fa-3x fa-spin\'></i></span>\n        </div>\n        <div class=\'p-3 mt-3 bg-highlight-red text-center \' ng-hide=\'performer\'><span class=\'lead text-danger\'>Please Select a Performer</span></div>\n        <div class=\'mt-4 p-3 d-flex flex-row justify-content-center align-items-center\' ng-show=\'performer\'>\n            <button ng-click=\'resetBoard()\' class=\'btn btn-light btn-lg\'>Cancel</button>\n            <button class=\'btn btn-primary btn-lg\'  ng-disabled=\'processing\' ng-click=\'saveScore()\'>Save Score</button>\n        </div>\n    </div>\n    \n    \n    <div class=\'mt-3\'>\n        <p class=\'pl-2 lead\'>Recent Entries</p>\n        <table class=\'table \'>\n            <tr>\n                <th>Performer</th>\n                <th>Technical</th>\n                <th>Athletic</th>\n            </tr>\n            <tr class=\'\' ng-repeat=\'s in scores\'>\n                <td></td>\n                <td></td>\n                <td></td>\n            </tr>\n        </table>\n    </div>\n</div>",
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
            
            /*Judge Score API*/
            // Create a new Judge Score Object
            createJudgeScore : function (obj) {
                // usually create by Judges
                return $http.post(url, {key : 200, data : ng.toJson(obj)});
                
            },
            // get JudgeScore by judge and groupId
            getJudgeScoreEntry : function (criteria) {
                return $http.get(url , {params : { key : 201, criteria : ng.toJson(criteria)}});
            },
            
            getCumulativeSportResult : function (groupId) {
                return $http.get(url, {params : { key  : 222 , data  : groupId}});
            }
            


        }
    }


})(angular);
