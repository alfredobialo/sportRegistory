/**
 * Created by USER on 1/17/2016.
 */
var Toast= {};
(function($,window){

   function slideMenuOut(elemRef) {
        var el  = $(elemRef);
            if(!el.hasClass("asom-mobile-menu"))
            {
              el.on("click","div.mobile-menu a.mobile",
                function (evt) {
                  // Hide the Menu
                  Toast.slideInMenu(elemRef);
                }
              );
              el.addClass("asom-mobile-menu");
              // Hide the Element

            }

          el
          .css({
            width : "250px",
            zIndex : 2000,
            position:"fixed",
            left:"-250px",
            top:0,
            bottom:0


          })
          .animate({
            left  : "0px",

          }, 700);




   }
   function slideMenuIn(elemRef) {
    var el  = $(elemRef)
      .css({
        width : "250px",
        zIndex : 2000,
        position:"fixed",

        top:0,
        bottom:0


      })
      .animate({
        left  : "-250px",

      })




  }



    Toast.slideOutMenu  = function (elemRef) {
     slideMenuOut(elemRef);
    };
  Toast.slideInMenu  = function (elemRef) {
   slideMenuIn(elemRef);
  };


  var winWidth  = $(window).width(), fixedWidth  = 700;
  if(winWidth < fixedWidth )
  {
    winWidth  = winWidth-20;
  }
  else{
    winWidth    = fixedWidth;
  }
    var showToast  = function(title,message,duration,toastType, isStatic)
    {
      var timer ;
        isStatic  = isStatic || false;
        toastType = toastType || "null_style";

        var ttype = "bg-primary", iconCss =  "ion-checkmark-circled";
        switch (toastType.toLowerCase()){
            case "error":
                ttype="bg-danger";
                iconCss="ion-asterisk";
                break;
            case "warning" :
                ttype = "bg-warning";
                iconCss="ion-alert-circled";
                break;
            case "info" :
                ttype = "bg-dormant";
                iconCss="ion-information-circled";
                break;
          case "success" :
          ttype = "bg-success";
          iconCss="ion-information-circled";
          break;
          default :
            ttype = toastType;
                break;

        }
        var cssClass = "asom-ui-toast-elem";
        title = title ||"";
        message = message || "Yeah! Your Action was Successful!";
        duration = duration || 6000;
      // var toastContainer  = "<div style='z-index:1100;" +
      //   "width : 460px; height: 600px; position :fixed; right: 10px;bottom: 10px;'>" +
      //   "</div>", domContainer  = $(toastContainer);
          var style  = (isStatic ? 'static-toast' : '');
        var domElem  = "<div class='theme-bg-color border-radius shadow-stronger-thick "+ style + " asom-toast-container '>" +
            "<div class='pad10  "+ttype+" text-center bold asom-toast-title-container'>"+ _.trunc(title,40)+"<span class='pull-right text-right'>" +
            "<button class='ui-button ui-button-xs ui-button-success ui-toast-close'> x</button></span></div>" +
            "<div class='pad10 text-left color-white'>" +
            "<span class='font-size-18 pull-left margin-r-10'><i class='"+iconCss+"'></i></span>" +
            "<span class='font-size-13 color-white'>"+ _.trunc(message,900) +"</span>" +
            "</div>" +

            "</div>"
        var elm  =  $(domElem);
        elm
            .addClass(cssClass)
            .css({
                width:"460px",
                display:"inline-block",
                zIndex : 3009,
            position : "fixed"})
            .animate({
                bottom  : calculateBottomPos(), // Toast should stack on each other
                right : 10


        }).appendTo($("body"));

      //   console.log( $(document), $(document).height());
      //  domContainer.css({height : $(document).height()});
      // domContainer.append(elm);
      // domContainer.appendTo($("body"));
            elm.find("button.ui-toast-close")
                .each(function(){
                   var current = $(this);
                    current.click(function(evt)
                    {
                      removeDomElem();
                      window.clearTimeout(timer);
                    });
                });

        if(!isStatic)
        {
          timer  = window.setTimeout(removeDomElem,duration);
        }
        function removeDomElem(){
                removeDom(elm);

        }
        function removeDom(element){
      element.css({
        position : "absolute",
      })
        .animate({
          top: "-=200px",
          bottom: 'auto',
          opacity : 0
        },500,function(){
          var rvm  = $(this);
          rvm.remove();
          // rearrangeToast( rvm);


        });

    }
        function calculateBottomPos()
        {
            // get all toast
            var height = 0,margin = 10;
            var allToast  = $("div."+cssClass);

            allToast
                .each(function(){
                   var theElem  = $(this);
                    height += theElem.height()+10;
                });
            return height + margin;
        }
        function rearrangeToast()
        {

            if(arguments.length>0)
            {
                var dom = arguments[0];

            }

            var height;
            var allToast  = $("div."+cssClass)
               .each(function(){
                   var theElem  = $(this);
                   height -= theElem.height();
               });
           alert("element Removed :  height =" + dom.height());
        }
    };
  Toast.showToast  = showToast;
    var pullDownNotification  =  function()
    {

    };
    var pullDownClass  = "asom-ui-pulldown",
        pullDownDefBgColor  = "bg-primary",pullUpDefBgColor  = "bg-success",
        pullUpClass = "asom-ui-pullup",defContainerId  = "app-main-menu";
    function getPulldownTemplate(mainContainerId, bgColorClass)
    {
        mainContainerId  = "#"+(mainContainerId || defContainerId);
        bgColorClass = bgColorClass || pullDownDefBgColor;
        // var containerTemplate=$("<div class='bg-white shadow-stronger min-h50 border-radius "+ pullDownClass+"' " +
        //   "style='position: fixed;" +
        //   "z-index: 1010;" +
        //   "width:700px'>" +
        //   "<div class='pad10 text-left "+ bgColorClass+"'>" +
        //   "<span class='font-size-14 text-center'><i class='ion-ios-bell'></i> Message Title Here! </span>" +
        //   "</div>" +
        //   "<div class='text-left asom-pulldown-content font-size-14' " +
        //   "style='position: fixed;" +
        //   "max-height: 550px;" +
        //   "overflow: auto;" +
        //   "padding: 15px;' >" +
        //   "</div>" +
        //   "</div>");


        var container  = $("<div/>" , {"class" :pullDownClass+ " " + bgColorClass +"  color-white shadow-stronger-thick border-radius"}),
            content  = $("<div/>",{"class"  : "min-h0 pad20 asom-pulldown-content font-size-13"});


        container
            .css(
                {
                    'position':'fixed',
                    zIndex : 8010,
                    width  : winWidth+'px',

                }
            );
            content.css(
                {"position": "relative",
                    maxHeight : '500px',
                    overflow : 'auto',
                    padding : "15px"
                });

                container
                    //.append(padder)
                    .append(content);
        // calculate the width of container
        var containerParent  = $(mainContainerId);
        if(containerParent.length <= 0 )
        {
            containerParent  = $('body');
        }
        var width  = $(window).width(), height = containerParent.height()
            , xpos  = (width - container.outerWidth(true))/2, ypos = -1*height;
        container.css({
           top  : ypos,
           left  : xpos,

        });
        // containerTemplate.css({
        //   top  : ypos,
        //   left  : xpos,
        //
        // });
        $(window).resize(function(){
            var width  = $(window).width(), height = containerParent.height()
                , xpos  = (width - container.outerWidth(true))/2, ypos = -1*height;
            container.css({
               // top  : ypos,
                left  : xpos,

            });
        });
        return container;
    }
    function getPullUpTemplate(mainContainerId,bgColorClass)
    {
        bgColorClass = bgColorClass || pullUpDefBgColor;
        mainContainerId  = "#"+(mainContainerId || defContainerId);
        var container  = $("<div/>" , {"class" :pullUpClass+ " " + bgColorClass + " color-white shadow-stronger-thick border-radius"}),
            content  = $("<div/>",{"class"  : "min-h30 pad10 asom-pullup-content font-size-13 text-center"}),
            padder  = $("<div/>", { "class"  : "min-h50"});

        container
            .css(
                {
                    'position':'fixed',
                    zIndex : 8000,
                    width  : winWidth+'px',

                }
            );
        content.css(
            {"position": "relative",
                maxHeight : '500px',
                overflow : 'auto',
                padding:'15px'
            });

        container
         .append(content);
        // calculate the width of container
        var containerParent  = $(mainContainerId);
        if(containerParent.length <= 0 )
        {
            containerParent  = $(document);
        }
        var width  = $(window).width(), height = containerParent.height()
            , xpos  = (width - container.outerWidth(true))/2;
        container.css({
            //top  : ypos,
            left  : xpos,

        });
        $(window).resize(function(){
            var width  = $(window).width(), height = containerParent.height()
                , xpos  = (width - container.outerWidth(true))/2;
            container.css({
                // top  : ypos,
                left  : xpos,

            });
        });
        return container;
    }
    Toast.pullDown  = function(contentHtml,isFixed,duration, bgClass, container)
    {
      // window.clearTimeout(Toast.timersHandle.timerPullDown);
        isFixed = isFixed || false;
        duration = duration || 6000;
        bgClass= bgClass || pullDownDefBgColor;
        //$("div."+pullDownClass)
        //    .remove();
        var closeClass = 'ui-button-success';
        if(bgClass.toLowerCase() == 'bg-success')
        {
            closeClass = 'ui-button-primary';
        }
        //if exit remove
      var elemC = $("div."+pullDownClass);
      if(elemC.length >0)
      {
        elemC.animate({top:"+=50px", opacity:0}, 200, function () {
          elemC.remove();
        });

      }

         var elem  = getPulldownTemplate(undefined, bgClass);
        var close  = $("<span title='Close' class='pull-right text-right margin-t-1  margin-l-10'>" +
            "<button class='ui-button ui-button-xs ui-toast-close " + closeClass+ "' > x</button></span>")
            .click(function(evt)
            {
                Toast.closePullDown();
            });

        var content  = elem.find(".asom-pulldown-content");

        content.html(contentHtml);
        if(isFixed)
        {
            content.prepend(close);
        }
        var parentContainer  = $('#'+defContainerId);
        if(parentContainer.length > 0)
        {
            parentContainer.after(elem);
        }
        else {

          var context = container || 'body';
          $(context).append(elem);
        }
        //$('#'+defContainerId).after(elem);
        elem.css({top:-1*elem.outerHeight(true),
            //       width : "0px",
            //height:"0px"
        });
        //(elem.outerHeight(true));
        elem.animate({
            top  : 130,
            //width : "500px",
            //height : "100px"
        }, 800, function(){
            if(!isFixed){
                Toast.timersHandle.timerPullDown  = window.setTimeout(function () {
                    Toast.closePullDown();  //TODO: $(this).remove
                }, duration);
            }
        });

    };
    Toast.timersHandle = {
      timerPullDown : null,
      timerPullUp : null
    };
    Toast.pullUp  = function(contentHtml,isFixed,duration, bgClass, container)
    {
        isFixed = isFixed || false;
        duration = duration || 6000;
        bgClass= bgClass || pullUpDefBgColor;
        //$("div."+pullDownClass)
        //    .remove();
        var closeClass = 'ui-button-success';
        if(bgClass.toLowerCase() == 'bg-success')
        {
            closeClass = 'ui-button-primary';
        }
        //$("div."+pullDownClass)
        //    .remove();
      var elemC = $("div."+pullUpClass);
      if(elemC.length >0)
      {
        elemC.animate({bottom:"+=50px", opacity:0}, 200, function () {
          elemC.remove();
        });

      }
        var theElem = $("div."+pullUpClass);

        var elem  = getPullUpTemplate(undefined, bgClass);
        var close  = $("<span title='Close' class='pull-right text-right  margin-r-10 margin-l-10'>" +
            "<button class='ui-button ui-button-xs ui-toast-close "+closeClass+"'> x</button></span>")
            .click(function(evt)
            {
                Toast.closePullUp();
            });

        var content  = elem.find(".asom-pullup-content");

        content.html(contentHtml);
        //if(theElem.length>0) // if the element is already in the dom, just replace the text
        //{
        //
        //    return;
        //}

        if(isFixed)
        {
            content.prepend(close);
        }
        var context = container || 'body';
        $(context).append(elem);
        elem.css({bottom:-1*elem.outerHeight(true)});
        //(elem.outerHeight(true));
        elem.animate({
            bottom  : 40
        }, 700, function(){
            if(!isFixed){
                Toast.timersHandle.timerPullUp  = window.setTimeout(function () {
                    Toast.closePullUp();
                }, duration);
            }
        });

    };
    Toast.closePullDown = function () {
        var elem = $("div."+pullDownClass);
        if(elem.length>0)
        {
            elem
                .animate({ top  : -1* elem.outerHeight(true),
                            opacity : 0.9
                }, 400, function(){
                    $(this).remove();
                  window.clearTimeout(Toast.timersHandle.timerPullDown);
                })
        }

    };
    Toast.closePullUp = function () {
        var elem = $("div."+pullUpClass);
        if(elem.length>0)
        {
            elem
                .animate({ bottom  : -1* elem.outerHeight(true),
                    opacity : 0.9
                }, 300, function(){
                    $(this).remove();
                  // Clear the Timer here
                  window.clearTimeout(Toast.timersHandle.timerPullUp);

                })
        }

    };
    Toast.pullDownInverse  = function(contentHtml, isFixed, duration)
    {
      Toast.pullDown(contentHtml,isFixed,duration, "bg-success")
    };
    Toast.pullUpInverse  = function(contentHtml, isFixed, duration)
    {
        Toast.pullUp(contentHtml,isFixed,duration, "bg-success")
    };

    Toast.showSuccess = function (title,message,duration) {
        Toast.showToast(title,message,duration,"success");
    };
    Toast.showPopup = function (title,message,duration, cssClass) {
      Toast.showToast(title,message,duration,cssClass);
  };
    Toast.showStaticPopup = function (title,message, cssClass) {
    Toast.showToast(title,message,0,cssClass,true);
  };
    Toast.showSuccessStaticPopup = function (title,message) {
    Toast.showToast(title,message,0,"success", true);
  };
    Toast.showErrorStaticPopup = function (title,message) {
    Toast.showToast(title,message,0,"error", true);
  };
    Toast.showInfoStaticPopup = function (title,message) {
    Toast.showToast(title,message,0,"info", true);
  };
    Toast.showWarningStaticPopup = function (title,message) {
    Toast.showToast(title,message,0,"warning", true);
  };
    Toast.showError = function (title,message, duration) {
        Toast.showToast(title,message,duration,"error");
    };
    Toast.showInfo = function (title,message,duration) {
        Toast.showToast(title,message,duration,"info");
    };
    Toast.showWarning = function (title,message,duration) {
        Toast.showToast(title,message,duration,"warning");
    };
    Toast.debug  = function(obj){
      Toast.pullDown(angular.toJson(obj,true), true,334,'bg-white-gradient');
    },
    Toast.showProgress = function () {
      var found  = $("div.asom-ui-progress").length > 0;
       if(!found)
       {
           //bg-accent-color
           var elem = $("<div class='pad10 bg-accent-color  shadow-stronger-thick-and-heavy asom-ui-progress'></div>");
           elem.css({
                   width : '190px',
                   height : '60px',
                   position : 'fixed',
                   zIndex : 10000,
                   right : -170,
                   top : 0
               })
               .animate({
                   right : 0,
               },600, function(){

               })

           ;
           elem.html("<span class='font-size-15'>Loading... Please wait</span>");
           $("body").append(elem);
       }

    };
    Toast.closeProgress = function () {
        var found  = $("div.asom-ui-progress").length > 0;
        if(found)
        {
            var elem = $("div.asom-ui-progress");

            elem
                .delay(1000)
                .animate({
                    right : -170,

                },600, function(){
                    $(this).remove();
                })

            ;
        }

    };
    Toast.removeDom  = function(element)
  {
    element.css({
      position : "absolute",
    })
      .animate({
        top: "-=200px",
        bottom: 'auto',
        opacity : 0
      },500,function(){
        var rvm  = $(this);
        rvm.remove();
        // rearrangeToast( rvm);


      });
  };
    Toast.closeStaticPopup  = function(){
      var elem  = $("div.static-toast");
      Toast.removeDom(elem);

    };

  
    return Toast;
})(jQuery, window);




