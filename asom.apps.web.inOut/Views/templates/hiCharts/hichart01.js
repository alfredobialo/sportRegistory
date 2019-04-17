/**
 * Created by USER on 4/19/2016.
 */
(function($,Highcharts, ng){

    var app = ng.module("app", ["ui.bootstrap", "ui.router", "ngAnimate", "ngMessages"]);

      app.controller("financeCtrl" , function ($scope) {

        $scope.accountInfo = {
          name : "James Okoye",
          accBal : 50000,
          accType : "Current"
        };
        $scope.showModel=function () {
          Toast.debug($scope.accountInfo);
        }
      });
      app.controller("UserManagerController" , ["$scope","RequiredServicesHere", UserManagerController]);
      app.factory("RequiredServicesHere", function () {
        return  {
            doSomethingOnServer : function () {
              return [];
            }
        }
      })
  function UserManagerController(scope) {
    scope.channels = [
    "ORG_ID_001 -- Head Office",
    "ORG_ID_002"
  ];
    scope.currentUser = {
      id : "secretId",
      password : 'password-secrete',
      displayName : 'John Okeke',
      isActive  :true,
      channelId : scope.channels[0]
    };

    scope.users = [];
    scope.addUser = function () {

      scope.users.push(angular.copy(scope.currentUser));
      Toast.debug(scope.users);
    }
  }

    var chartOptions = {
        chart  : {
            renderTo : "chartContainer-01",
            type: 'column',
            margin:70,
            //plotBorderWidth  : 2,
            //plotBorderColor : 'red',
            //borderColor : 'blue',
            //borderRadius : 3,
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                depth: 50,
                viewDistance: 25

        },
            plotOptions : {
                column:{depth : 20},

            }
        },

        title : {
            text : 'Sales for Today'
        },
        credits : {
            text:'asom services (effectiv business accounting)',
            //href: "www.asomservices.com",

        },
        yAxis  : {
            title : {
                text : 'Percentage %'
            }
        },
        xAxis :  {
             categories : ['1990','1991','1992', '1993', '1994','1995','1996'],
            labels : {
                step : 1
            }
        },
        series : [{
            type:'spline',
            color:'red',
            name : 'Onitsha Branch Sales'  ,
            data : [45000,117000,33200,170000,24900,73400,37800]
        },{
            name : 'Nnewi Branch Sales'  ,
            data : [70000,129000,25220,89000,54900,33400,17800]
        },
            {
                name : 'Owerri Branch Sales'  ,
                data : [200029,79000,335220,39000,54900,63400,47800]
            }
        ]

    };
    $(function(){

        // Toast.pullDown("<p class='font-size-18'> This a Popup Toast, and is Fixed</p>", true,3000);
        // var theChart  =  new Highcharts.Chart(chartOptions);
      var video  = $("#videoPlayer");
      navigator.getUserMedia   = navigator.getUserMedia
        || navigator.mozGetUserMedia ||
        navigator.webkitGetUserMedia
      if(navigator.getUserMedia)
      {
          navigator.getUserMedia({
          video :true,
          audio : false
          }, function (stream) {
            window.URL  = window.URL || window.webkitURL;
            var blob = window.URL.createObjectURL(stream);
            video.get(0).src  = blob;
            video.get(0).play();
              console.log(blob);
        }, function () {
          Toast.pullDown("FAILED VIDEO OUTPUT")
        });
      }
      else{
        Toast.pullUp("Webcam NOT Supported!");
      }

        //console.log(theChart);
    })
})(jQuery, Highcharts, angular);
