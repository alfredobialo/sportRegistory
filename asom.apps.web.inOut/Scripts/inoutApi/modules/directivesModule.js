/**
 * Created by USER on 8/13/2016.
 */
(function(ng, $){
    var ui  = ng.module("asom.ui", [])
        .directive("asomToolbar",["$window",AsomToolbar])
        .directive("asomFileUpload", [AsomFileUpload])
        .directive("focusInput", [FocusInput])
        .directive("asomChart", [AsomHighchartDirective])
        .directive("asomDataPager", [AsomDataPager])
        .directive("asomDateRangePicker", [AsomDateRangePicker])
        .directive("asomClock",["$interval",AsomClockUI])
        .directive("asomTimer",[AsomTimer])
        .directive("asomAccordion",[simpleMobileMenuAccordion])

          .directive("asomRoutePageDetails", ["$rootScope", AsomRoutePageDetailsDirective])
    
    ;
      
      function AsomRoutePageDetailsDirective($rootScope) {
        function controller(scope) {
           
           /* scope.toParams  = $rootScope.toParams;
            scope.toState  = $rootScope.toState;
            scope.fromParams  = $rootScope.fromParams;
            scope.fromState  = $rootScope.fromState;*/
            console.log("DIRECTIVE SCOPE",$rootScope);
        }
          return {
              template: "<div class=\"row\">\n    <div class=\"col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12\">\n        <div class=\"page-header\">\n            <h2 class=\"pageheader-title\">\n                <span ng-if=\'toState.data.title\'>{{toState.data.title}}</span>\n                <span ng-if=\'!toState.data.title\'>Welcome {{currentUser.displayName}}</span>\n            </h2>\n            <p class=\"pageheader-text\">{{toState.data.description}}</p>\n            <div class=\"page-breadcrumb\">\n                <nav aria-label=\"breadcrumb\">\n                    <ol class=\"breadcrumb\">\n                        <li class=\"breadcrumb-item\" ng-if=\'false\'>\n                            <a href=\"#\" class=\"breadcrumb-link\">{{fromState.data.title}}</a>\n                        </li>\n                        <li class=\"breadcrumb-item active\" aria-current=\"page\">{{toState.data.description}}</li>\n                    </ol>\n                </nav>\n            </div>\n        </div>\n    </div>\n</div>\n",
              //scope: {},
              controller : ["$scope", controller]
          }
      }
  function simpleMobileMenuAccordion() {
      /*
      * find all target elements
      * then collaspe all and make the selected menu to be active
      * */
      return {

          link : function (scope, elem, attr) {
              elem.each(function () {
                $(this).next("div.mobile-menu").hide();
                $(this).click(function (evt) {

                  // $(elem).addClass("selected-menu");

                  $(this).next().slideToggle(500 , function () {
                      //   elem.each(function () {
                      //    var el  = $(this);
                      //    if(!el.hasClass("selected-menu"))
                      //    {
                      //      el.next().slideUp();
                      //      $(elem).removeClass("selected-menu");
                      //    }
                      //    //
                      // })
                  });
                });
              });

          }
      };



    }




  function AsomClockUI(timer) {
    return {
      restrict: "EA",
      template: "<span>{{currentTime | date:'hh:mm:ss a'}}</span>",
      // link  : function (scope, $elem, $attr) {
      //   $elem.html("Updated Clock");
      //   var timer;
      //   window.setInterval(function () {
      //     timer  = (new moment(new Date(),"hh:mm:ss"));
      //     Toast.showInfo("CLOCK", "Clock Ticking",1000)
      //    }, 1000);
      //   $elem.html(timer);
      // }
      controller: ["$scope", function (scope) {
        scope.currentTime = {};
        timer(function () {

          scope.currentTime = new moment().toDate();

        }, 1000);
      }]
    };
  }
  function AsomTimer() {
    return {
      restrict: "EA",
      scope : {
        time : "="
      },

      link : function (scope,elem ,attr) {
        if(scope.time)
        {
          var dt   =   moment(scope.time).utc().toDate();

          elem.countdown(dt, function(event) {

            $(this).text(

              event.strftime('%D d, %H hrs :%M mins :%S secs')
            );

          });
        }


      }
      // template: "<span>{{countDown | date:'hh:mm:ss a'}}</span>",
      // // link  : function (scope, $elem, $attr) {
      // //   $elem.html("Updated Clock");
      // //   var timer;
      // //   window.setInterval(function () {
      // //     timer  = (new moment(new Date(),"hh:mm:ss"));
      // //     Toast.showInfo("CLOCK", "Clock Ticking",1000)
      // //    }, 1000);
      // //   $elem.html(timer);
      // // }
      // controller: ["$scope", function (scope) {
      //   scope.countDown = {};
      //   if(scope.time)
      //   {
      //     timer(function () {
      //
      //       scope.countDown = new moment(scope.time).toDate();
      //       //.log(scope.countDown);
      //     }, 1000);
      //   }
      //
      // }]
    };
  }
  function FocusInput() {
    return{
      restrict : "A",
      link : function (scope,elem,attr) {
        //Toast.pullDown("AM A FOCUS INPUT DIRECTIVE!");
        window.setTimeout(function(){
          elem.focus();
        },700);


      }
    }
  }
  function AsomHighchartDirective()
  {
    // Expect Highchart to be loaded


    return {

      link : function($scope, element, attr)
      {
        var chartOptions = {
          chart  : {
            renderTo : "elementId",
            type: 'area',
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
            categories : ['Mon','Tue','Wed', 'Thur', 'Fri','Sat'],
            labels : {
              step : 1
            }
          },
          series : [{
            type:'spline',
            color:'red',
            name : 'Onitsha Branch Sales'  ,
            data : [45000,117000,33200,170000,24900,73400]
          },{
            name : 'Nnewi Branch Sales'  ,
            data : [70000,129000,25220,89000,54900,33400]
          },
            {
              name : 'Owerri Branch Sales'  ,
              data : [200029,79000,335220,39000,54900,63400]
            }
          ]

        };
        //(attr);
        chartOptions.chart.type  = /*angular.isDefined(attr['type']) ? */attr['type'] || 'column';
        chartOptions.title.text  = /*angular.isDefined(attr['title']) ?*/ attr['title'] || 'Chart Title Goes Here';
        var use3d  = angular.isDefined(attr['render3d']) ? attr['render3d'] : 'false';
        if(angular.isDefined(attr['xaxis'] )){
          chartOptions.xAxis = $scope.xAxis;
          chartOptions.yAxis = $scope.yAxis;
          chartOptions.series = $scope.series;
          // Toast.pullDown("xAxis Attr Defined");
          //(chartOptions)

        }


        if(use3d.toLowerCase() == 'true')
        {
          chartOptions.chart.options3d.enabled  = true;
        }
        else{
          chartOptions.chart.options3d.enabled  = false;
        }
        var theChart  =  $(element).highcharts(chartOptions);/*new Highcharts.Chart(chartOptions)*/;
        element.addClass("shadow");

      },
      restrict : 'AE',
      scope : {
        type : '@',
        title : '@',
        render3d : '=',
        xAxis  : '=',
        yAxis  : '=',
        series  : '=',
      }
    }
  }
  function AsomFileUpload()
  {
    var linkfunc = {
      restrict : "E",
      replace : true,
      scope : {
        supportsMultiple  : "@",
        'class' : '@',
        name : '@',
        uploadText : '@',
        uploadIcon : '@',
        fileChange : '&',
        accept  : "@"

      },
      //controller : ["$scope","$element",function($scope,elem)
      //{
      //
      //    //(elem,$scope ,"Directive Controller");
      //}],
      link  : function(scope, elem, attr)
      {
        var opt = {

          supportsMultipleUpload : attr["supportsMultiple"] || false,
          uploadCssClass : attr['class'] || "ui-button ui-button-primary",
          uploadName : attr['name'] || 'file',
          formAction  : attr['uploadUrl'] || "/",
          hideFile:true,
          buttonText  : attr['uploadText'] || "",
          buttonIconClass  : attr['uploadIcon'] || "",
          fileType : ["*"],
          accept : attr['accept'] ||"image/*,video/*"//,video/*"

        };
        function init(parent)
        {
          //Toast.showInfo("Upload UI" , "Custom File Upload initialized", 6000);
          parent.css({cursor  : 'pointer'});
          var timespan  =  new Date().getTime()+ _.random(0,10);
          var unique_id="asom_file_upload_"+timespan;
          var form =  $("<form />",{
              method : 'post',
              action  :opt.formAction,
              enctype :'multipart/form-data',
              target : unique_id+'_upload_ifr',
              'class' : unique_id+'_upload_form',
              id : unique_id+'_upload_form'

            }),
            iframe  = $("<iframe />",{
              width:'0px',
              height : '0px',
              id : unique_id+'_upload_ifr',
              name :unique_id+'_upload_ifr',
              frameborder : 0

            });
          iframe.css({
            position : 'absolute',
            left : '-999px',
            top : '-220px',
            width:"0px",
            height:"0px"


          });
          // create the element
          $("input[type=file]."+unique_id+'_upload_btn',form).remove();
          var ui  = $("<input />",{
            type: "file",
            name : opt.uploadName ,
            //'class' :opt.uploadCssClass,
            accept : opt.accept,
            title  : "Choose File"

          });
          if(opt.supportsMultipleUpload)
          {
            ui.attr({multiple :true})


          }

          ui.addClass(unique_id+"btn")
            .on("change", function (evt) {
              var fileui= $(this).get(0);
              scope.fileChange({
                obj : {
                  form :form,
                  fileInput :fileui,
                  iframe :iframe,
                  event : evt
                }

              });
              //scope.$apply();
            });
          if(opt.hideFile)
          {

            var assignCss  = (parent.data("css-class"));
            form.css({
              position : 'relative',
              display:'inline-block',
              'overflow':'hidden'
            });
            // TODO: modify to use hyperlinks if issues noticed : by Alfred Obialo
            var btn  = $("<a />",{
              'class' : opt.uploadCssClass || assignCss || "ui-button ui-button-default",
              href : ''
            }).css({display : "inline-block"})
              .html("<i class='"+opt.buttonIconClass+"'> </i>  "+ opt.buttonText);

            ui.css({
              opacity : 0,
              "filter": "alpha(opacity=0)",
              position :'absolute',
              zIndex : 100,
              display:'inline-block',
              left : 0,
              top : 0,



            });


            form.append(btn);

          }
          form.append(ui);


          // Create the iframe for upload
          parent.removeAttr("class");
          parent.append(form).append(iframe);
          var oh = btn.outerHeight(true) < 20 ? 45+"px"  : btn.outerHeight(true)+"px",
            ow = btn.outerWidth(true) < 100 ? 250+"px"  : btn.outerWidth(true)+"px";


          ui.css({height  :  oh,
            width  : ow,
            padding : btn.css('padding'),
            margin : btn.css('margin')
          });
        }
        ////(attr,scope);
        init(elem);

      }

    };
    return linkfunc;
  }
  function AsomToolbar($window){
    var defaultOpts  = {
      shadowThick :{
        'box-shadow': '6px 4px 7px 0px rgba(48, 48, 48, 0.6)'
      },
      shadowClass: "shadow-stronger-thick",
      currentOffset : 0,
      topPosition  : 0,
      offset : 0,
      stickyClass : "asom-toolbar-sticky"
    };
    function init(elem)
    {
      defaultOpts.currentOffset =  elem.offset().top;
      defaultOpts.topPosition  = elem.position().top;
      elem.wrap($("<div/>"));
      elem.attr({"data-initial-pos" : defaultOpts.topPosition})
        .css({
          //minHeight  : "40px",
          display  : "inline-block"

        });
    }

    return {
      restrict : "A",  // applied as Attribute (A) E, M C
      scope : {
        offsetToElementId : "@"
      },

      link  : function ($scope, elem, attr) {
        if(angular.isDefined(attr["offsetToElementId"]))
        {
          var idElement  = $("#"+attr["offsetToElementId"]);
          // Increase ZIndex Of  OffsetElement
          defaultOpts.offset  = idElement.outerHeight(true);
        }
        var offset = defaultOpts.offset;
        function makeStatic()
        {
          elem.css({
            position : "fixed",
            top  :$("#"+attr["offsetToElementId"]).height(),//parseInt(attr["offset"]),
            zIndex : 1000

          })
            .css(defaultOpts.shadowThick);


        }
        function makeNormal()
        {
          elem.css({
            position : "relative",
            zIndex : 800,
            top  : 0
          }). css("box-shadow", "none")
        }

        init(elem);
        var initPos  = parseInt(elem.data("initial-pos")) ;
        var container  = elem.parent();
        elem.css({
          position  :"relative",
          width  : container.width()+"px"
        });
        // register function if elem is availablle

        $($window).on("scroll.toolbar resize.toolbar load.toolbar", function(evt){
          elem.css({width  : container.css("width")});//container.width() + "px"
          // Toast.pullDown("Container Width is " + container.width()+" <br /><p class='font-size-16'> Toolbar width is : "+elem.width()+"</p>", true);
          //(container.width(),container.css("width"));
          var elm  = $(this), scrollTop =  elm.scrollTop(), scrollTopPlusOffset  = scrollTop +offset;
          if(scrollTop >= (initPos - $("#"+attr["offsetToElementId"]).outerHeight(true)))
          // if(scrollTop >= ($("#"+attr["offsetToElementId"]).outerHeight(true))+50)
          {
            $("#"+attr["offsetToElementId"]).css({zIndex:1020,"box-shadow": "none"});
            // remove shadow

            makeStatic();
          }
          else if((elem.position().top >= offset)  )
          {
            makeNormal();
          }
          if(scrollTop <= 0 )
          {
            makeNormal();
          }
        });

      }
    }
  }

  function AsomDataPager()
  {
    return {
      scope : {
        pagerSource : "=",
        showAsPageNumbers : "=",
        onPageClick : "&",
        pagerCssClass: "="

      },
      template  : "<span ng-if='showAsPageNumbers==false'>" +
      "<button class='ui-button btn btn-primary-xs' " +
      "ng-click='gotoPrevPage()' >&lt; Prev</button>" +
      " Page <span class='bold theme-caption-color'>{{pagerSource.currentPage|number}}</span> of {{pagerSource.totalPages|number}} Page(s) <span class='bold'> Total: {{pagerSource.totalRecord|number}}</span>  " +
      "<button class='ui-button btn btn-primary-xs' " +
      "ng-click='gotoNextPage()' >Next &gt;</button>" +
      "Jump to Page <select name='' id='' ng-model='pagerSource.currentPage' " +
      " class='ui-input-border'>" +
      "<option  ng-repeat='p  in pageNumber' value='{{$index+1}}'>{{$index+1}}</option>" +
      "</select> <button class='ui-button ui-button-default ui-button-xs' ng-click='linkClick($event,pagerSource.currentPage)'>Go</button>" +

      "</span>"+
      "<span ng-if='showAsPageNumbers'>" +
      "<a href='' " +
      "ng-repeat='pg in pageNumber'" +
      "ng-click='linkClick($event,$index+1)' " +
      "ng-class='{\"bg-success\":pagerSource.currentPage == ($index+1)}'" +
      "class='link-button button-xxs'>{{$index+1}}</a>" +

      " <small class='font-size-11'><span ng-show='pagerSource.totalRecord==0'>No Record</span><span ng-show='pagerSource.totalRecord>0'>Record: <b>{{pagerSource.totalRecord|number}}</span> </b></small></span>",
      controller : ["$scope",function(scope)
      {



        scope.showControls  = false;
        scope.linkClick  =  function(evt,index)
        {
          // set the current page accordingly
            scope.pagerSource.currentPage = index;
            scope.onPageClick({index:index});

        };
        // scope.pagerSize = 'xs';
        scope.pageNumber  = [];
        scope.$watch("pagerSource", function (obj) {

            if(obj)
            {
              if(obj.totalPages>15)
              {
                scope.showAsPageNumbers  = false;
              }
              scope.pageNumber  = _.range(obj.totalPages);

            }



        });
        scope.gotoNextPage = function () {
          if(scope.pagerSource.currentPage < scope.pagerSource.totalPages)
          {
            scope.pagerSource.currentPage  += 1;
            scope.onPageClick({index:scope.pagerSource.currentPage});
          }
        };
        scope.gotoPrevPage = function () {
          // only goPrev if we are not BOF
          if(scope.pagerSource.currentPage>1)
          {
            scope.pagerSource.currentPage  -= 1;
            scope.onPageClick({index:scope.pagerSource.currentPage});
          }


        };
      }],
      link : function (scope, elem, attr) {
            //.log(scope);
            if(!angular.isDefined(attr["showAsPageNumbers"]))
            {
                scope.showAsPageNumbers  = true;
            }
      }

    }

  }
  function AsomDateRangePicker()
  {
    /*
    * <input class="ui-input "
     close-text="Close"
     name="txtDueDate"
     ng-disabled="uiMode.disabled"
     ng-focus="dueDateIsOpen =true"
     ng-click="dueDateIsOpen =true"
     uib-datepicker-popup="dd/MMMM/yyyy" is-open="dueDateIsOpen"
     max-date="accountPeriod.endDate"
     min-date="accountPeriod.startDate"
     max-mode="day"
     ng-model="so.dueDate" placeholder="Payment Due Date" />
    * */
    return {
      scope : {
        dateSource : "="


      },
      template  : "<div class=\'row\'><div class=\'col-sm-4\'>" +
      "<input type=\'text\' " +
      "ng-focus=\'startDate=true\' " +
      "ng-click=\'startDate=true\' " +
      "uib-datepicker-popup=\'dd-MMM-yyyy\' " +
      "is-open=\'startDate\' placeholder=\'Start Date\' " +
      "ng-model=\'dateSource.dateInterval.startDate\'" +
      " class=\'border-radius ui-input font-size-11\'>" +
      "</div>" +
      "<div class=\'col-sm-3 clear-boostrap-padding-in-row\'>" +
      "<input type=\'text\' " +
      "ng-focus=\'endDate=true\'" +
      " ng-click=\'endDate=true\' " +
      "uib-datepicker-popup=\'dd-MMM-yyyy\' " +
      "is-open=\'endDate\' placeholder=\'End Date\' " +
      "ng-model=\'dateSource.dateInterval.endDate\'" +
      " class=\'border-radius ui-input font-size-11\'></div>" +
      "<div class=\'col-sm-2 clear-boostrap-padding-in-row\'><input type=\'checkbox\' ng-model=\'dateSource.searchByDateRange\'> <small class=\'font-size-9\'>Use Date</small></div>" +
      "<div class=\'col-sm-3 clear-boostrap-padding-in-row\'>" +
      "<div uib-dropdown class=\"display-inine-block\">\n  <button href=\"\" class=\"ui-button ui-button-xs ui-button-default\"\n          uib-dropdown-toggle\n  >\n  Choose Date &nbsp; <i class=\"ion-chevron-down\"> </i>\n\n  </button>\n  <ul uib-dropdown-menu>\n\n    <li ng-repeat=\'d in dateRange\'><a href=\"\" ng-click=\"setDate(d.dateInterval)\">{{d.title}}</a></li>\n    <li>\n\n      \n  </ul>\n</div>" +
      "</div>" +
      "</div>" ,
      controller : ["$scope","IdentityService",function(scope, IdentityService)
      {
        scope.dateRange  = [];
        function getDateRanges() {
          IdentityService.getDateRanges()
            .then(function (response) {
              scope.dateRange  = response.data.data;

            })
        }

        getDateRanges();
        scope.setDate  =  function(d)
        {
          // //(d);
          scope.dateSource.dateInterval  = d;
          scope.dateSource.dateInterval.startDate = moment(d.startDate).toDate();
          scope.dateSource.dateInterval.endDate = moment(d.endDate).toDate();
          scope.dateSource.searchByDateRange  = true;
        };
        // scope.pagerSize = 'xs';

        // scope.$watch("dateSource", function (obj) {
        //
        //   if(obj)
        //   {
        //
        //     //(obj);
        //   }
        //
        // });

      }]

    }

  }


  ng.module("asom.ui.topNav", [])
    .directive("asomToolbar",["$window",AsomToolbar]);

})(angular, jQuery);
