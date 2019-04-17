(function(ng){
  ng.module("dialogModule", ["ui.bootstrap"])
    .factory("DialogService", ["$uibModal", DialogService]);

  function  DialogService($modal)
  {
     var res  =
       {
          openSalesOrderDialog  :  function (resolvedData)
          {
            resolvedData  = resolvedData || {
                salesOrder  : null,
                addNew : true,
                showDialog : true,
                fetchSalesOrder  : false,
                editMode : false,
                buttons  : {
                  ok  : 'Am Done!',
                  cancel  : "Close"

                }
              };
            Toast.showProgress();
            var url  = effectiv.urls.partialsUrl+"?id=sales-order-dialog";
            var params  = {
              resolve : {
                data : function()
                {
                  return resolvedData;
                }
              },
              templateUrl : url,
              controller : 'SalesController'
            };

            var modal  =  res.showFullScreenDialog(params,function () {
              Toast.closeProgress();


            });

            return modal;

          },
          openCustomerDialog  : function (resolvedData) {
            resolvedData  = resolvedData || {
                customer  : null,
                addNew : true,
                showDialog : true,
                editMode : false,
                buttons  : {
                  ok  : 'Am Done!',
                  cancel  : "Cancel"

                }
              };
            Toast.showProgress();
            var url  = effectiv.urls.partialsUrl+"?id=customer-ui-dialog";
            var params  = {
              resolve : {
                data : function()
                {
                  return resolvedData;
                }
              },
              size : 'xlg',
              templateUrl : url,
              controller : 'CustomerController'
            };

            var modal  =  res.showFullScreenDialog(params,function () {
              Toast.closeProgress();


            });

            return modal;

          },


          setDialogContentHeight : function()
          {
            var dialogFooterHeight =  90;
            var winHeight  = $(window).height(),
               modalTop  =  parseInt($("div.modal-dialog").css('top')),
              dialogHeaderHeight  = $("div.modal-header").height(),
              dialogBodyHeight  = $("div.modal-body")
              .css({
                  overflow  : "auto",
                  textAlign : "text-left",
                  maxHeight  : (winHeight  - (dialogHeaderHeight +modalTop  + dialogFooterHeight)),
                  height : (winHeight  - (dialogHeaderHeight  + dialogFooterHeight))
                });

            function  calculateHeight()
            { winHeight  = $(window).height();
              dialogHeaderHeight  = $("div.modal-header").height();
              dialogBodyHeight  = $("div.modal-body")
                .css({
                  overflow  : "auto",
                  textAlign : "text-left",
                  maxHeight  : (winHeight  - (dialogHeaderHeight +modalTop  + dialogFooterHeight)),
                  height : (winHeight  - (dialogHeaderHeight  + dialogFooterHeight))
                });

            }

            $(window).on('resize.dialog',(function(evt){
              calculateHeight();
            }));

            // $(document).resize();


          },
          showConfirmDialog : function (controller ,resolve) {
              var modalInstance  = $modal.open({
                resolve  : resolve,
                template  : "<div class=''>" +
                "<div class='pad10 bg-success text-center'>" +
                "<span class='font-size-14'>{{dialogMessage.title}}</span>" +
                "<button class=' pull-right ui-button ui-button-danger ui-button-xs' ng-click='closeDialog()'>X</button>" +
                "</div>" +
                "<div class='modal-body pad20 bg-white text-left max-height-300 overflow-auto min-h70'>" +
                  "{{dialogMessage.content}}" +
                "</div>" +
                "<div class='pad10 bg-gray text-left'>" +
                "<button class='ui-button-flat-danger ui-button ui-button-sm' ng-click='closeDialog()'>{{buttons.cancel || 'Cancel' }}</button>" +
                "<button class='pull-right ui-button-success ui-button ui-button-sm' ng-click='ok()'>{{buttons.ok || 'Ok Proceed'}}</button>" +
                "</div>" +
                "</div>",
                controller  : controller || 'DefaultDialogController',
                backdrop  :'static',
                size : 'dialog-size'
              });
              return modalInstance;
          },
          showInputDialog : function (resolve, onRenderCompleteCallback) {

          var modalInstance  = $modal.open({
            resolve  : resolve,
            template  : "<div class=''>" +
            "<div class='pad10 bg-success text-center'>" +
            "<span class='font-size-14'>{{dialogMessage.title}}</span>" +
            "<button class=' pull-right ui-button ui-button-danger ui-button-xs' ng-click='closeDialog()'>X</button>" +
            "</div>" +
            "<div class='modal-body pad20 bg-white text-left max-height-350 overflow-auto min-h100'>" +
            "<p>{{dialogMessage.content}}</p>" +
            "<textarea rows='3' maxlength='100' ng-model='dialogMessage.input' class='ui-input ui-input-border font-size-14'></textarea>" +
            "<small class='color-red font-size-12'>Report will be printed in <span class='font-size-13'>{{dialogMessage.format}}</span></small>" +
            "</div>" +
            "<div class='pad10 bg-gray text-left'>" +

            "<button class='ui-button-flat-danger ui-button ui-button-sm' ng-click='closeDialog()'>{{buttons.cancel || 'Cancel' }}</button>" +
            "<button class='pull-right ui-button-success ui-button ui-button-sm' ng-click='ok()'>{{buttons.ok || 'Ok Proceed'}}</button>" +
            "</div>" +
            "</div>",
            controller  :'DefaultDialogController',
            backdrop  :'static',
            size : 'dialog-input-size'
          });

              if(onRenderCompleteCallback)
              {
                modalInstance.rendered.then(function () {
                  onRenderCompleteCallback();
                });

              }

          return modalInstance;
        },
          showPasswordInputDialog : function (resolve, onRenderCompleteCallback) {

         var modalInstance  = $modal.open({
           resolve  : resolve,
           template  : "<div class=''>" +
           "<div class='pad10 bg-success text-center'>" +
           "<span class='font-size-14'>{{dialogMessage.title}}</span>" +
           "<button class=' pull-right ui-button ui-button-danger ui-button-xs' ng-click='closeDialog()'>X</button>" +
           "</div>" +
           "<div class='modal-body pad20 bg-white text-left max-height-350 overflow-auto min-h100'>" +
           "<p>{{dialogMessage.content}}</p>" +
           "<input type='password'  maxlength='40' ng-model='dialogMessage.password' class='ui-input ui-input-border font-size-18' />" +

           "</div>" +
           "<div class='pad10 bg-gray text-left'>" +

           "<button class='ui-button-flat-danger ui-button ui-button-sm' ng-click='closeDialog()'>{{buttons.cancel || 'Cancel' }}</button>" +
           "<button class='pull-right ui-button-success ui-button ui-button-sm' ng-click='ok()'>{{buttons.ok || 'Ok Proceed'}}</button>" +
           "</div>" +
           "</div>",
           controller  :'DefaultDialogController',
           backdrop  :'static',
           size : 'dialog-input-size'
         });

         if(onRenderCompleteCallback)
         {
           modalInstance.rendered.then(function () {
             onRenderCompleteCallback();
           });

         }

         return modalInstance;
       },
          showDeleteTicketConfirmationDialog : function (resolve, onRenderCompleteCallback) {

           var modalInstance  = $modal.open({
             resolve  : resolve,
             template  : "<div class=''>" +
             "<div class='pad10 bg-success text-center'>" +
             "<span class='font-size-14'>{{dialogMessage.title}}</span>" +
             "<button class=' pull-right ui-button ui-button-danger ui-button-xs' ng-click='closeDialog()'>X</button>" +
             "</div>" +
             "<div class='modal-body pad20 bg-white text-left max-height-350 overflow-auto min-h100'>" +
             "<p>{{dialogMessage.content}}</p>" +
             "<div class='pad10'>" +
             "<span class='font-size-14'>{{dialogMessage.extraContent.content}}</span>" +
             "" +
             "</div>" +
             "<textarea rows='3' maxlength='100' ng-model='dialogMessage.input' class='ui-input ui-input-border font-size-14'></textarea>" +
             "<small class='color-red font-size-12'>Report will be printed in <span class='font-size-13'>{{dialogMessage.format}}</span></small>" +
             "</div>" +
             "<div class='pad10 bg-gray text-left'>" +

             "<button class='ui-button-flat-danger ui-button ui-button-sm' ng-click='closeDialog()'>{{buttons.cancel || 'Cancel' }}</button>" +
             "<button class='pull-right ui-button-success ui-button ui-button-sm' ng-click='ok()'>{{buttons.ok || 'Ok Proceed'}}</button>" +
             "</div>" +
             "</div>",
             controller  :'DefaultDialogController',
             backdrop  :'static',
             size : 'dialog-input-size'
           });

           if(onRenderCompleteCallback)
           {
             modalInstance.rendered.then(function () {
               onRenderCompleteCallback();
             });

           }

           return modalInstance;
         },
          openDialog :function (title, content, okBtn , cancelBtn, successCallback){
          var modal = this.showConfirmDialog(null,{
          dialogMessage  : function(){
          return {title:title,
            content :content};
        },
        buttons :function () {
          return {
            ok  : okBtn,
            cancel :cancelBtn
          }
        }
      }
    );

    modal.result.then(function () {

      if( successCallback)
      {
        successCallback();
      }


    }, function () {

    });
    return modal;
  },
         openPasswordInputDialog :function (title, content, okBtn , cancelBtn, successCallback){
           var modal = this.showPasswordInputDialog({
               dialogMessage  : function(){
                 return {title:title,
                   content :content,
                    password  : null
                 };
               },
               buttons :function () {
                 return {
                   ok  : okBtn,
                   cancel :cancelBtn
                 }
               }
             }
           );

           modal.result.then(function (data) {

             if( successCallback)
             {
               successCallback(data.password);
             }


           }, function () {

           });
           return modal;
         },
        showFullScreenDialog : function (params,onRenderCompleteCallback ) {

            /*
            * We Expect Params  = {
            *   controller,templateUrl, resolve
            * }
            * */
            params.backdrop ='static';
            params.size= params.size || 'full-screen';
          var modalInstance  = $modal.open(params);

          if(onRenderCompleteCallback)
          {
            modalInstance.rendered.then(function () {
              res.setDialogContentHeight();
              onRenderCompleteCallback();
            });

          }
          modalInstance.result.then(function () {

            $(window).off('resize.dialog');
          },function () {
            $(window).off('resize.dialog');
          });
          return modalInstance;
        },
        showWideScreenDialog : function (params,onRenderCompleteCallback ) {

          /*
           * We Expect Params  = {
           *   controller,templateUrl, resolve
           * }
           * */
          params.backdrop ='static';
          params.size=  '90-top-10-screen';
          var modalInstance  = $modal.open(params);

          if(onRenderCompleteCallback)
          {
            modalInstance.rendered.then(function () {
              onRenderCompleteCallback();
            });

          }
          modalInstance.result.then(function () {
              $("window").off("resize.dialog");
          }, function () {
            $("window").off("resize.dialog");

          });
          return modalInstance;
        }



      };
      return res;
  }

})(angular);
