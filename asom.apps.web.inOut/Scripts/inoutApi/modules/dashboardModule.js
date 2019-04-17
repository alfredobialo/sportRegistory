/**
 * Created by USER on 1/13/2016.
 */
(function(ng, window, Highcharts){

    ng.module("dashboardModule", [])
      .controller("HomeController", ["$scope", "$state","$stateParams", HomeController])
      .controller("DashboardController", ["$scope", "$state","$stateParams", DashboardController]);
    function HomeController(scope, state, stateParams)
    {
      scope.name = "Alfred Obialo";
      scope.state = state.current;
      scope.params = stateParams;

    }
    function DashboardController(scope, state, stateParams)
    {
      scope.name = "james Okafor";
      scope.state = state.current;
      scope.params = stateParams
      scope.menuTitle  = state.current.data.title;
      scope.chartType="column";
      scope.chartOptions = {

        yAxis  : {
          title : {
            text : 'Detailed Analysis %'
          }
        },
        xAxis :  {
          categories : ['Jumia','Tonimas Inc','Ben Gas Ltd', 'Asom Services', 'Vogue Pay Ltd','Konga'],
          labels : {
            step : 1
          }
        },
        series : [{
          type:'area',
          color:'orange',
          name : 'Debtors'  ,
          data : [45000,117000,33200,170000,24900,73400,37800]
        }
        ]

      };

    }

})(angular, window , Highcharts);
