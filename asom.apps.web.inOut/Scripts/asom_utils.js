function runTest(targetDivClass, viewPortId, top) {

    //top = top || 69;  // Store the initial offset top postion in a jquery.data object
//alert(top);
    var wnd = $(window);

    wnd.on("scroll resize load", function(evt){
        var viewport  = $(viewPortId);
        var windowHeight  = wnd.height();

        var viewPortHeight  = viewport.outerHeight(true);
        var elem  = $(targetDivClass).first();
        var height  = elem.outerHeight(true);
        var scrollTop = $(this).scrollTop();
        var canScroll = (height >= windowHeight) || (height > windowHeight);// var canScroll = height+scrollTop < viewPortHeight;

        if(canScroll)
        {
          if (height < windowHeight)
          {
            elem.css({position  : 'fixed'});
          }
          else{
            var hw  = (height - windowHeight)-80;
            elem.css({position : 'relative'});
            if(scrollTop >= hw)
            {

              elem.css({position  : 'fixed'});
              elem.css({top  : '-'+hw+"px"});
            }
            else{
              elem.css({position : 'relative'});
              elem.css({top  : 0+"px"});
            }
          }
            // if(scrollTop <=top)
            // {
            //     elem.css({position  : 'fixed'})
            // }
            // else if(height < windowHeight){
            //   elem.css({position : 'fixed'});
            // }
            // else {
            //   elem.css({position : 'relative'});
            // }

        }
        else{
          elem.css({position  : 'fixed'});
            if (height > viewPortHeight)
            {
                // Toast.pullDown("Should NOT SCROLL ,  Height : " +height+ ", VIEW PORT Height : " + viewPortHeight +
                //     "<p class='font-size-14'> Scroll Top : " + scrollTop + "</p>", true);
                elem.css({position : 'relative'});
            }


        }
      // Toast.pullUp("CAN SCROLL : " + canScroll + ", Height : " +height+ ", VIEW PORT Height : " + viewPortHeight +
      //   "<p class='font-size-14'> Scroll Top : " + scrollTop + "</p>", true);

    });
wnd.scroll();


}
/**
 * Created by Alfred Obialo on 25/06/2014.
 */
function runAllStaticMenu()
{
    runTest("div.action-center","div.action-canvas",0);
    //runTest("div.skoologic-ads-scroll","div.static-scroll-viewport",80);

}

$(function() {



    runAllStaticMenu();
    //slideMenu();
    // My Lazy Man Accordion
    var accordion  = $("div.left-nav a.head,div.left-nav a.active-menu");
    accordion.removeClass("active-menu").next().slideUp();
    accordion.each(function()
    {
        var elm  = $(this);
        elm.click(function (evt) {

            // find ul


            if(elm.hasClass("active-menu"))
            {
                //accordion.removeClass("active-menu").next().slideUp();
                elm.removeClass("active-menu");
                elm.next().slideUp(400, function () {

                });
            }
            else
            {
                accordion.removeClass("active-menu").next().slideUp();
                elm.next().slideDown(400);

                elm.addClass("active-menu");
            }


            evt.preventDefault();
        })
        // //.log(elm.html());
    });

    // Look for accordion that are mark as data-active='true',
    // expand them
    $("div.left-nav a.head[data-active]").click();


    var navBarCssClassOnFloat  ="top-nav-shadow", offsetHeight = 0;
    var topNav = $("div.top-menu"),
        divLogo2 =$("div.logo2"),
        headerSection = $("div.top-menu"),
        win = $(window).on("scroll resize load", function (evt) {


            var pgy = window.pageYOffset;
            if (pgy > headerSection.outerHeight(true) + offsetHeight) {

                topNav
                    .addClass(navBarCssClassOnFloat)

                    .css({
                        position: "fixed",
                        top: "0px",
                        textAlign : "",
                        width: $("div.action-canvas").width() ,
                        zIndex: 1000


                    });

                divLogo2.removeClass("display-none");


            }
            else if (pgy <= headerSection.outerHeight(true) + offsetHeight) {
                topNav.css({
                    position: "relative",
                    top: "auto",
                    width: "100%",
                    zIndex: 1000 })
                    .removeClass(navBarCssClassOnFloat);
                divLogo2.addClass("display-none");

            }
            //
             });
    new Animator({
        name : "Alfred Obialo",
        direction : "l-r",
        delay : 6000,
        elementAnimator  : "div.animator",
        elementUl : "ul.ads",
        onSlide : function(index)
        {
            var elem  =  $("div.changeMe");
            if(index  === 0)
            {
                elem.addClass("bg-gradient-green")
                    .removeClass("bg-gradient-blue bg-gradient-red bg-gradient-black")       ;
            }
            else if(index === 1)
            {
                elem.addClass("bg-gradient-red")
                    .removeClass("bg-gradient-green bg-gradient-blue bg-gradient-black");
            }
            else if(index === 2)
            {
                elem.addClass(navBarCssClassOnFloat)
                    .removeClass("bg-gradient-green bg-gradient-red bg-gradient-black");
            }
            else if(index === 3)
            {
                elem.addClass("bg-gradient-black")
                    .removeClass("bg-gradient-green bg-gradient-red bg-gradient-blue");
            }
            else
            {
                elem.addClass("bg-gradient-red")
                    .removeClass("bg-gradient-green bg-gradient-blue bg-gradient-black");
            }

        }
    }).animate();

});
function hideRightNav()
{
    var oldRightNavClass= "col-sm-12 col-lg-3 col-md-3 min-h200 ";
    var newClassMainContainer = "col-sm-12 col-lg-12 col-md-12 col-xs-12 min-h300",
        newClassSubContainer  = "col-sm-9 col-md-10 min-h200",
        newClassLeftNav ="col-sm-3 col-md-2 hidden-xs min-h200 slide-menu-target";
    // look for data-hide-right=true

}
function slideMenu()
{


    var addedCss = "shadow-stronger-fade-lite bg-white";
    var setVisibleAttr  =  {

        zIndex : 500,
        left : "10px",
        top : "0px",
        width : ($(window).width()>300 ? "55%": "70%")
        },
        setHiddenAttr  = {
            position  : "absolute",
            zIndex : "inherit",
            left : "0px",
            top : "0px"

        };

    var btnSlider  = $("button.slide-menu"),
        leftNav  = $("div.left-nav"),
        leftMenu  = $("div.slide-menu-target"),
        isVisible = function () {
           return leftMenu.hasClass("slide-menu-visible");
        },
        isBtnSliderVisible  = function () {
            btnSlider  = $("button.slide-menu:visible");
            return btnSlider.length >0 ;
        },
        showMenu = function () {


            // left Nav click binding
            ///onl do these for visible buton#
            if(isBtnSliderVisible()) {
                leftNav.on("click", "nav>ul>li>a", function(evt) {
                    //alert($(evt.currentTarget).html());
                    hideMenu();
                });

            }

            leftMenu
                .addClass("slide-menu-visible " + addedCss)
                .removeClass("hidden-xs")
                .css({
                    position : "absolute",
                    zIndex : 500
                })
                .animate(setVisibleAttr,400, function () {

                });
        },
        hideMenu = function () {

            //Unbind click
            if(isBtnSliderVisible())
            {
                leftNav.unbind("click");
            }
            leftMenu
                .addClass("hidden-xs")
                .removeClass("slide-menu-visible " + addedCss)
                .removeAttr("style");
        }


    //also watch when the button is no longer visible, so we can undo any css attributes added dynamically
    // this should be done on window resize event

    $(window).resize(function (evt) {
        var isBtnVisible  = isBtnSliderVisible();
        if(!isBtnVisible)
        {
            hideMenu();
        }
       if(isVisible())
       {
           // readjust


       }
    });
    //Target our left nav when this button is clicked

    btnSlider.click(function (evt) {
        // if the menu is visible, hide it, else show it
        if(isVisible())
        {
            // close menu here
            // reset menu to default
           hideMenu();

        }
        else{

            // set relavant css properties
            showMenu();

        }

        evt.preventDefault();
    })

}


function Animator(options)
{
    var defOption  = {
        direction  : "r-l",
        delay : 4000,
        speed  : 800,
        pauseOnHover : false,
        elementAnimator  : "div.animator",
        elementUl : "ul",
        width:"925px",
        height:"350px",
        onSlide  : $.noop()


    };
    var  index  = -1;
    var opt  = $.extend({},defOption,options,{}) ;

    var ul=$(opt.elementUl),uiWid,container  = $(opt.elementAnimator);
    /*container.css({
     width:opt.width,
     height:opt.height
     });*/

    container.css({height  : opt.height});
    var margin  = parseInt(opt.width),//container.width(),
        delay  = opt.delay,
        margin2  = "";
    ul.find("li")
        .each(function()
        {
            $(this).css({width  : margin +"px"});
           // alert($(this).css("width"));

        });
    //alert(margin);
    var liTotalWidth;
    //  //.log("LENGTH OF LI = ", ul.find("li").length);

    var aniSpeed  = opt.speed;

    // we assume Right to Left animation for now //
    var dir  = opt.direction || "r-l"; //right to left
    function init()
    {
        // ul = $(opt.elementUl);

        var cdir  =opt.direction.toLowerCase();
        // perform initialization here
        if( cdir=== "r-l" )
        {


            liTotalWidth = (ul.find("li").length ) * margin;
            uiWid = liTotalWidth;
            //extend the ul width to be sum of all li's width
            ul.css({width  : liTotalWidth+"px"});
        }
        else if(cdir === "l-r")
        {
            liTotalWidth = (ul.find("li").length ) * margin;
            // then we have to set some interesting variables
            uiWid = (liTotalWidth-margin)* -1;
            ul.css({
                marginLeft  : "-"+(liTotalWidth-margin)+"px",
                width  : liTotalWidth+"px"
            });

        }
    }
    init();


    this.animate = function()
    {
        var that  =  this;
        var cdir  =opt.direction.toLowerCase();
        if(cdir === "r-l")
        {
            margin2  = uiWid > margin ? "-="+margin+"px"  : "0px";

            ul.delay(delay)
                .animate({
                    marginLeft   : margin2

                },aniSpeed, function () {
                    //var ue   = $(this);
                    ++index;
                    if(opt.onSlide)
                    {
                        opt.onSlide(index)
                    }
                    if(uiWid <= 0)
                    {
                        uiWid = liTotalWidth;
                        index  = -1;
                    }
                    else
                    {
                        uiWid -= margin;

                    }
                    // //.log(uiWid);
                    //window.setTimeout(this.animate,delay);

                    that.animate();

                });
        }
        else if(cdir === "l-r")
        {
            margin2  = uiWid < 0 ? "+="+margin+"px"  : "-"+(liTotalWidth-margin)+"px";
            //.log(margin2,uiWid);
            ul.delay(delay)
                .animate({
                    marginLeft   : margin2

                },aniSpeed, function () {
                    //var ue   = $(this);
                    ++index;
                    if(opt.onSlide)
                    {
                        opt.onSlide(index)
                    }
                    if(uiWid >= 0)
                    {
                        uiWid = (liTotalWidth-margin) * -1;
                        index  = -1;
                    }
                    else
                    {
                        uiWid += margin;

                    }
                    // //.log(uiWid);
                    //window.setTimeout(this.animate,delay);

                    that.animate();

                });
        }

    }



}

(function ($) {



    $.fn.asomFileUpload = function (opts) {

        var uploadUIOptions = {

        supportsMultipleUpload : true,
        uploadCssClass : null,
        uploadName : "file",
            fileChange : jQuery.noop,
            formAction  : "",
            hideFile:true,
            buttonText  : 'Select File',
            buttonIconClass  : 'ion-camera',
            fileType : ["*"],
            accept : "image/*"//,video/*"

    };
        function init(parent, index)
        {
            //Toast.showInfo("Upload UI" , "Custom File Upload initialized", 6000);
            parent.css({cursor  : 'pointer'});
            var timespan  =  new Date().getTime();
             var form =  $("<form />",{
                method : 'post',
                action  :opt.formAction,
                enctype :'multipart/form-data',
                target : 'asom_ifr'+index+timespan,
                'class' : 'asom-upload-form',
                id : 'asom_upload'+index +timespan

            });
            var iframe  = $("<iframe />",{
                width:'0px',
                height : '0px',
                id : 'asom_ifr'+index+timespan,
                name :'asom_ifr'+index+timespan,
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
            $("input[type=file].asom-upload",form).remove();
            var ui  = $("<input />",{
                type: "file",
                name : opt.uploadName,
               // 'class' :opt.uploadCssClass,
                accept : opt.accept,
                title  : "Upload Picture or File"

            });
            if(opt.supportsMultipleUpload)
            {
                ui.attr({multiple :true})


            }
            ui.addClass('asom-upload')
                .on("change", function (evt) {
                    // code that will be executed goes here
                    opt.fileChange(form,$(this).get(0),iframe.get(0),evt);
                   });
                if(opt.hideFile)
                {

                   var assignCss  = (parent.data("css-class"));
                    form.css({
                        position : 'relative',
                        display:'inline-block',
                        'overflow':'hidden'
                    });
                    var btn  = $("<a />",{
                        'class' : opt.uploadCssClass || assignCss || "ui-button ui-button-primary",
                        href : ''
                    }).css({display : "inline-block"}).html("<i class='"+opt.buttonIconClass+"'> </i>  "+ opt.buttonText);

                    ui.css({
                    opacity : 0,
                        "filter": "alpha(opacity=0)",
                    position :'absolute',
                    zIndex : 100,
                       display:'inline-block',
                        padding : btn.padding,
                        margin : btn.margin,
                        left : 0,
                        top : 0,
                        height : '200px'


                });


                    form.append(btn);

                }
            form.append(ui);

            // Create the iframe for upload

            parent.append(form).append(iframe);
        }


        //extend options
        var opt  = $.extend({},uploadUIOptions,opts);
        var that  = (this);

        that.each(function (index) {

            var e = $(this);
            init(e,index);

        });
        return that;
    };


    // Create a new Upload Component
// using the data api to create ui
    // check for elements with the right attribute

    $(function () {

        var asom  = $("div.asom-fileupload");

        //read all data options
        var opts ={
            supportsMultipleUpload : asom.data("multiple"),
            uploadCssClass : asom.data("upload-css-class"),
            fileChange : function(form, fileui, iframe, evt){Toast.showSuccess("File Selected" ,"File Selected \n File Name : " + fileui.files[0].name)},
            formAction  : asom.data("action"),
            hideFile:asom.data("hide-file"),
            buttonText  : asom.data("button-text"),
            fileType : ["*"],
            accept : asom.data("accept")//,video/*"

        };

         asom.asomFileUpload(opts);


    })




})(jQuery);

