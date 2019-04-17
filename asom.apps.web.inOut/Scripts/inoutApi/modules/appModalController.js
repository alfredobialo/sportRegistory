/**
 * Created by USER on 6/5/2016.
 */
(function(){
    angular.module(effectiv.appName)
      .controller("CustomerDialogController",["$scope","$uibModalInstance","CustomerService","selectedCustomer","dialogUI","FileUploadService","NigerianStateService","SalesService","$filter", CusDialog])
      .controller("ItemEditDialogController",["$scope","DialogService","$uibModalInstance","ItemService","selectedItem","FileUploadService","OrgInfoService", ItemEditDialogController])
      .controller("CreateNewUserController",["$scope","$uibModalInstance","IdentityService", CreateNewUserController])
      .controller("DefaultDialogController", ["$scope","dialogMessage","buttons", "$uibModalInstance" ,DefaultDialogController])
    ;

  // function InputDialogController(scope, dialogMessage , buttons  , $modalInstance) {
  //   scope.dialogMessage  = dialogMessage;
  //
  //   scope.buttons  = buttons;
  //   scope.closeDialog = function () {
  //     $modalInstance.dismiss();
  //   }
  //   scope.ok = function () {
  //     $modalInstance.close();
  //   }
  //
  // }
    function DefaultDialogController(scope, dialogMessage , buttons  , $modalInstance) {
        scope.dialogMessage  = dialogMessage;
        scope.buttons  = buttons;
        scope.closeDialog = function () {
            $modalInstance.dismiss();
        }
        scope.ok = function () {
            $modalInstance.close(dialogMessage);
        }

    }
        function CusDialog(scope, $modalInstance,CustomerService,selectedCustomer,dialog, fileUploadService,utilService,SalesService , $filter) {
          scope.salesHistoryCriteria  = {
            pageSize : 30,
            currentPage  : 1,
            queryString : null,
            searchByCustomer : true,


          };
          scope.currentContact = {
            isEditMode  : false,
            customerId : null,
            tempPic : null
          };
          scope.sortField  = '';
          scope.reverse = false;
          scope.order = function (sortField) {
            scope.reverse  = (scope.sortField == sortField) ? !scope.reverse  : false;
            scope.sortField  = sortField;
          };
          scope.totalBal =0.0;
          scope.sumSalesTotal = function () {
            var total = 0.0, bal = 0.0;
            var filtered  = $filter('filter')(scope.salesOrder,scope.salesHistoryCriteria.queryString);
            _.map(filtered, function (s) {
              total += s.netTotal;
              bal += s.balance;
            });
            scope.totalBal  = bal;
            return total;
          };

          scope.printInvoice  = printInvoiceReport;
          function printInvoiceReport(salesOrder,index)
          {
            // set loading to true
            // Toast.pullDown("Print Invoice Called");
            var format  = index == 1 ? "word" : index == 2 ? "pdf" : "pos";
            SalesService.printInvoice(salesOrder.invoiceNo,format)
              .then(function (response) {
                if(response.data.success)
                {
                  Toast.showSuccess("Invoice Report generated","Invoice Report for " + salesOrder.customerName + " was generated " +
                    "successfully with invoice number : " + salesOrder.invoiceNo, 15000 );
                  window.open(response.data.data.url,"Invoice Report Printout", null, false);
                  // window.location.href=response.data.data.url;
                }
                else{
                  Toast.pullUp(response.data.message);
                }
              })
          }
          scope.loadingHistory  = false;
          scope.total  = 0.0;
          scope.salesOrder = [];
          function loadSalesHistory(){
            scope.loadingHistory  = true;

            SalesService.getSalesOrders(scope.salesHistoryCriteria)
              .then(function (response) {
                scope.loadingHistory  = false;
                if(response.data.success){

                  scope.sortField  = '';
                  scope.reverse  = false;
                  scope.total  = 0.0;
                  scope.salesOrder  = response.data.data;



                  scope.salesHistoryCriteria  = response.data.criteria;
                }
                else {
                  Toast.pullDown(response.data.message, true, 44, 'bg-danger');
                }
              });

          }
          scope.addContact= function () {
            // add if we are not in editMode
            if(!scope.currentContact.isEditMode)
            {
              // add to temp list
              scope.currentContact.customerId = scope.currentCustomer.id;
              scope.currentContact.id = _.uniqueId();
              scope.currentContact.tempPic = angular.copy(scope.contactPassport);
              scope.currentCustomer.contacts.push(angular.copy(scope.currentContact));
              scope.contactPassport.opacity =0.2;
              scope.currentContact = {};
            }
          };
          scope.editContact = function(contact){
            if(!contact.isEditMode)  // we havn't save the contact yet
            {
              // populate the Ui for editing and remove the contact from the list
              scope.currentContact  = contact;
              scope.contactPassport.opacity =1;
              scope.removeContact(contact);
            }
          };
          scope.removeContact=function (contact) {
            _.remove(scope.currentCustomer.contacts, {id : contact.id}) ;
          };
          scope.uploadPicture = uploadPicture;
          function uploadPicture(obj, index)
          {

            fileUploadService.onFileUploadChange(obj, function (response) {
              //
              if(response.success)
              {
                if(index == 1)
                {
                  scope.passport= {'background-image' : "url('"+response.files[0].autoFileUrl+"')",
                    opacity : 1
                  };
                  scope.currentCustomer.companyLogoUrl  = response.files[0].name;
                }
                else if(index==2) { // Contact Upload
                  scope.contactPassport= {'background-image' : "url('"+response.files[0].autoFileUrl+"')",
                    opacity : 1
                  };
                  scope.currentContact.pictureUrl  = response.files[0].name;

                }
                else if(index ==3) // for multiple product images
                {

                }
                scope.$apply();
              }
              else {
                Toast.pullDown(response.errorMessage);
              }
            });
          }
            scope.priceLevels = CustomerService.customerPriceLevel;
            // scope.uploadPicture = function(obj)
            // {
            //
            //     fileUploadService.onFileUploadChange(obj, function (response) {
            //         //
            //         if(response.success)
            //         {
            //             scope.passport= {'background-image' : "url('"+response.files[0].autoFileUrl+"')",
            //                 opacity : 1
            //             };
            //             scope.currentCustomer.companyLogoUrl  = response.files[0].name;
            //             scope.$apply();
            //         }
            //         else {
            //             Toast.pullDown(response.errorMessage);
            //         }
            //     });
            // };
            scope.dialog  = dialog.dialog;
            scope.type = [{
                key : 1 , value : 'Buyer'}
            // },
            //     {
            //         key : 2 , value : 'Supplier'
            //     },
            ];

           // scope.currentCustomer  = selectedCustomer;
            scope.currentCustomer = {
                id : null,
                type  : scope.type[0],
                isCompany : false,
                priceLevel : scope.priceLevels[0],
                isActive : true,
                hasAccount : false,
                isCreditWorthy : false,
                creditLimit : 0,
                contacts : []
            };

          if(dialog.dialog.mode ==2){
            scope.currentCustomer = selectedCustomer;
            scope.salesHistoryCriteria.queryString = selectedCustomer.id;
            loadSalesHistory();
            scope.passport= {'background-image' : "url('"+scope.currentCustomer.companyLogoUrl+"')",
              opacity : 1
            };
            _.map(scope.currentCustomer.contacts, function (obj) {
              obj.tempPic = {
                'background-image': "url('" + obj.pictureUrl + "')"
              };
            });
            if (scope.currentCustomer.isSupplier)
              scope.currentCustomer.type = CustomerService.customerGroup[1];
            else
              scope.currentCustomer.type = CustomerService.customerGroup[0];
          }
          scope.$watch("currentCustomer.name", function (newValue) {
            scope.currentCustomer.name  = _.capitalize(newValue);
            if(!scope.currentCustomer.isEditMode){
              scope.currentCustomer.id = (_.kebabCase(newValue)).toUpperCase();
            }

          });
          scope.$watch("currentCustomer.type", function(value)
          {
            scope.currentCustomer.isSupplier  = value.key == 2;

          });
            scope.countries  = [];
            scope.states = [];
            scope.allLocations  = [];
            var countries = utilService.getCountries().then(function (response) {
                //Toast.debug(response.data.data);
                scope.countries  = response.data.data;
                utilService.getStates().then(function(response)
                {
                    scope.states =  response.data.data;
                    scope.allLocations = _.union(scope.states,scope.countries);

                });
            });

            scope.enableCustomerType = !false;
            scope.showUpload  =!false;
            // for edit Mode Only, and we make a copy
            scope.saveCustomer = function () {
                scope.loading  = true;

              if(scope.currentCustomer.isEditMode && scope.dialog.mode == 2)
              {
                // Update to database

                CustomerService.updateCustomer(scope.currentCustomer)
                  .then(function(response){
                    scope.loading  =false;
                    if(response.data.success)
                    {

                      Toast.pullUp(response.data.message);
                      $modalInstance.close(response.data.data);
                    }
                    else {
                      Toast.pullUp(response.data.message, false, 7000 , 'bg-danger');
                    }
                  });
              }
              else{
                CustomerService.createCustomer(scope.currentCustomer)
                  .then(function(response){
                    scope.loading  =false;
                    if(response.data.success)
                    {
                      Toast.pullUp(response.data.message);
                      $modalInstance.close(response.data.data);
                    }
                    else {
                      Toast.pullUp(response.data.message);
                    }
                  });
              }

            };
            scope.dialogSaveCustomer  = function () {
               scope.saveCustomer();

            };
            scope.dismissDialog  = function () {
                 $modalInstance.dismiss();
            };

        }
        function CreateNewUserController(scope, modalInstance,identityService) {

        }
        function ItemEditDialogController(scope,DialogService, $modalInstance, ItemService,selectedItem, fileUploadService,OrgInfoService)
        {




          scope.openDeleteDialog  = openDialog;
          function openDialog(){
            var modal=DialogService.showConfirmDialog(null,{
                dialogMessage  : function(){
                  return {title:"Please Confirm Your Action",content :"Do you really want to DELETE this ITEM and all it's Record?\n "+scope.item.name};
                },
                buttons :function () {
                  return {
                    ok  : 'Delete',
                    cancel :'No Please'
                  }
                }
              }
            );

            modal.result.then(function () {

              deleteItem();
            }, function () {

            })
          }

            scope.appSettings  = {};
            // let get the appSettings

            var temp_storageType = {
              costPrice : 0.00,
              retailPrice : 0.00,
              wholesalePrice : 0.00,
              distributorPrice: 0.00,
              reorderPoint : 1,
              unitOfMeasure : "Unit",
              description : null,
              itemId : null,
              isEditMode  :false


            };
            scope.stockHistoryCriteria ={
              pageSize : 10,
              currentPage : 1,
              findByChannelId : true,
              queryString : null,
              channelId : null
            };
            scope.goPage = function (index,s) {
              getStockHistory(s, s.criteria);

            };
            scope.viewHistory= getStockHistoryFor;
            function getStockHistoryFor(storageType)
            {
              getStockHistory(storageType, scope.stockHistoryCriteria);
            }
            function getStockHistory(storageType, criteria)
            {
              storageType.loadingHistory = true;
              scope.stockHistoryCriteria.queryString  = storageType.id;

              ItemService.getStockUnitHistory(criteria)
                .then(function (response) {
                  storageType.loadingHistory  = false;
                  if(response.data.success)
                  {

                    storageType.stockHistoryList = response.data.data;
                    var sum  = 0, negSum =0;
                    _.map(storageType.stockHistoryList, function (h) {

                      if(h.mainUnit > 0){
                        sum += h.mainUnit;
                      }
                      else {
                        negSum += Math.abs(h.mainUnit);
                      }

                    });
                    storageType.totalUnitIn  = sum;
                    storageType.totalUnitOut = negSum;
                    storageType.criteria = response.data.criteria;
                    // storageType.
                  }
                  else{
                    Toast.pullUp(response.data.message,false, 7000,'bg-danger');
                  }
                })
            }
            scope.unitOfMeasures = [];
            scope.category = {
              name :null,
              isChild : false,
              id  :null
            };
            scope.uiMode = {
              isDisabled: false,
              modelEditable : true,
              editButtonText : "Edit Item",
              cancelEditButtonText : "Cancel",

            }
            scope.storageType = {
              costPrice : 0.00,
              retailPrice : 0.00,
              wholesalePrice : 0.00,
              distributorPrice: 0.00,
              reorderPoint : 1,
              unitOfMeasure : "Unit",
              description : null,
              itemId : null,
              stockValue  : null,
              unitInStock : 0,


            };

            var stockManager = {
              unit : null,
              note : null,
              transId : null,
              transDesc : "STOCK-IN"
            };
            scope.itemType = [ 'PROD.', 'SERV'];

            scope.loading  = false;
            scope.picture = null;
            //.log(stateParams);
            //.log(state.$current, state);
            scope.$parent.pageTitle  = "Edit Inventory Item";
            var itemModel = {
              isBought : true,
              storageType : [],
              isEditMode : false,
              isCountable  : true,
              isStockable : true,
              isForSale : true,
              isDiscountable : true,
              isTaxable : true,
              isActive : true
            };
            scope.item = {
              isBought : true,
              storageType : [],
              isEditMode : false,
              isCountable  : true,
              isStockable : true,
              isForSale : true,
              isDiscountable : true,
              isTaxable : false,
              isActive : true
            };
         getItemById(selectedItem.id);
          // scope.item= selectedItem;
            function setPriceFromUI() {
              scope.storageType.retailPrice = Math.abs(scope.storageType.costPrice + Math.abs(scope.storageType.retailPrice));
              scope.storageType.wholesalePrice = Math.abs(scope.storageType.costPrice + Math.abs(scope.storageType.wholesalePrice));
              scope.storageType.distributorPrice = Math.abs(scope.storageType.costPrice + Math.abs(scope.storageType.distributorPrice));
            }
            function setPriceFromModel() {
              scope.storageType.retailPrice = Math.abs(scope.storageType.costPrice - scope.storageType.retailPrice);
              scope.storageType.wholesalePrice = Math.abs(scope.storageType.costPrice - scope.storageType.wholesalePrice);
              scope.storageType.distributorPrice = Math.abs(scope.storageType.costPrice - scope.storageType.distributorPrice);
            }
            scope.addStorageType = function(){
              // validate input

              if (!scope.uiMode.isDisabled){

                if (scope.storageType.isEditMode){
                  // perform Update here
                  // scope.storageType.isEditMode = false;

                  // perform Update on the server here

                  scope.loading  = true;
                  setPriceFromUI();
                  ItemService.updateStorageType(scope.storageType)
                    .then(function(response){
                      scope.loading  = false;
                      if (response.data.success)
                      {
                        Toast.pullUpInverse(response.data.message)
                      }
                      else {
                        Toast.pullUp(response.data.message,false,10000, "bg-danger","div.dialog-ui");
                      }


                    });

                  var index  = _.findIndex(scope.item.storageType, function (st) {
                    return st.id == scope.storageType.id;
                  });
                  if (index>=0)
                  {
                    //setPriceFromUI();
                    scope.item.storageType[index] = scope.storageType;
                  }
                  scope.storageType = angular.copy(temp_storageType);

                }
                else{
                  // add new Storage Type


                  setPriceFromUI();
                  scope.storageType.itemId = scope.item.id;
                  scope.storageType.itemTag = scope.item.name;
                  if (scope.item.isEditMode)
                  {
                    scope.loading  = true;
                    ItemService.addStorageType(scope.storageType)
                      .then(function(response){
                        scope.loading  = false;
                        if (response.data.success)
                        {
                          scope.item.storageType.unshift(response.data.data);
                          scope.storageType = angular.copy(temp_storageType);
                          Toast.pullUpInverse(response.data.message)
                        }
                        else {
                          Toast.pullUpInverse(response.data.message, false,6000, 'bg-danger');
                        }


                      });
                  }
                  else{
                    scope.item.storageType.unshift(scope.storageType);
                    scope.storageType = angular.copy(temp_storageType);
                  }

                }

                // scope.item.storageType.unshift(angular.copy(scope.storageType));
                // scope.storageType = angular.copy(temp_storageType);
              }

            };
            scope.cancelStorageTypeEdit = function()
            {
              scope.storageType = angular.copy(temp_storageType);
            };
            scope.editStorageItem = function(item)
            {
              item.isEditMode = true;
              scope.storageType=angular.copy(item);
              // Toast.debug(scope.storageType);
              setPriceFromModel();
              // reload the storage Item to the UI
              /* if we are editing  a storage item and the user adds the item back to the list of items,
               *    we need to update the item instead of inserting new item
               * */
            };
            scope.updateStock  = updateStock;
            function updateStock(storageType) {
              if (scope.item.isEditMode)
              {
                scope.loading  = true;
                ItemService.addBeginingStock(storageType)
                  .then(function (response) {
                    scope.loading = false;
                    if (response.data.success)
                    {
                      // unit in stock added
                      Toast.pullUp("<p class='font-size-14'>"+ response.data.message + "</p>");
                      // update item stock
                      storageType.unitInStock += storageType.stockValue;
                      storageType.stockValue = storageType.reorderPoint;
                    }
                    else{
                      Toast.pullUp(response.data.message,false,  10000, "bg-danger","div.dialog-ui");
                    }
                  });
              }
              else{
                Toast.pullUp("The Current Item :'" + scope.item.name + "' must be in editable Mode!");
              }

            }

            scope.deleteStorageItem = function (item) {
              // delete on server
              // remove from list of items
              if(confirm("Do you want to Delete this Item Storage? "))
              {
                var index  = scope.item.storageType.indexOf(item);
                if(scope.item.storageType.indexOf(item) >-1)
                {
                  // if item.isEditMode , delete from Server
                  if(item.isEditMode)
                  {
                    // delete from Server
                    scope.loading = true;
                    // ItemService
                    ItemService.deleteStorageType(item)
                      .then(function (response) {
                        scope.loading = false;
                        if (response.data.success)
                        {
                          // unit in stock added
                          Toast.pullUp("<p class='font-size-14'>"+ response.data.message + "</p>");
                          // update item stock
                          // storageType.unitInStock += storageType.stockValue;
                          // storageType.stockValue = storageType.reorderPoint;
                        }
                        else{
                          Toast.pullUp(response.data.message,false,  10000, "bg-danger","div.dialog-ui");
                        }
                      });

                  }
                  scope.item.storageType.splice(index,1);
                }
              }

            };
            scope.item.itemType  = scope.itemType[0];
            //scope.breadCrum = "Items " +"/"+stateParams.mode + (stateParams.id !== "" ? ("/" + stateParams.id ) : "");
            scope.categories  = [] ;// list of categories
            scope.getCategories  = function(){
              // return all categories
              ItemService.getCategories()
                .then(function(response){
                    if(response.data.success)
                    {
                      scope.categories = response.data.data;
                      // //(scope.frmStorageType, scope.frmInventoryItem);

                    }
                  },
                  function (status) {


                  }
                )
            },
              scope.getUnitOfMeasures  = function(){
                // return all categories
                ItemService.getUnitOfMeasures()
                  .then(function(response){
                      if(response.data.success)
                      {
                        scope.unitOfMeasures = response.data.data;

                        // //(scope.unitOfMeasures);

                      }
                    },
                    function (status) {


                    }
                  )
              };
            function addCategory(category)
            {

              ItemService.addCategory( category)
                .then(function (response) {
                  if(response.data.success)
                  {
                    scope.categoryName  = null;
                    //add the newly category
                    scope.category  = response.data.data;
                    scope.categories.push(scope.category);


                  }
                  else{
                    Toast.pullDown("<p class='font-size-14'> "+ response.data.message+"</p>")
                  }

                });
              // create category
            }

            function addUnitOfMeasure(um)
            {
              ItemService.addUnitOfMeasure( um)
                .then(function (response) {
                  if(response.data.success)
                  {
                    scope.storageType.unitOfMeasure  = um;
                    scope.unitOfMeasures.push(
                      {unitMeasure : scope.storageType.unitOfMeasure,
                        description  :  scope.storageType.unitOfMeasure,
                        id  :  scope.storageType.unitOfMeasure
                      });


                  }
                  else{
                    Toast.pullDown("<p class='font-size-14'> "+ response.data.message+"</p>")
                  }

                });
              // create category
            }

            scope.getCategories();
            scope.getUnitOfMeasures();
            scope.createCategory  = createCategory;

            function createCategory(category ,evt)
            {
              if(evt.keyCode == 13) // ENTER KEY
              {
                if(!scope.frmItemCategory.$valid)
                {
                  Toast.pullDown("Enter a Category Name");

                }
                else{
                  //add category

                  if (angular.isDefined(scope.category)){
                    var catMain  = angular.copy(scope.category);
                    catMain.name = category;
                    //(cat);
                    addCategory(catMain);
                  }
                  else{
                    addCategory({name:category , id : category});
                  }




                }
              }

            }
            scope.createUM = createUM;
            function createUM(value ,evt)
            {

              if(evt.keyCode == 13) // ENTER KEY
              {
                evt.preventDefault();
                if(!scope.frmMain.frmStorageType.txtUnitOfMeasure.$valid)
                {
                  Toast.pullDown("Enter a Unit of Measure");

                }
                else{
                  //add category
                  var cat  = angular.copy(value);
                  addUnitOfMeasure(cat);

                }
              }

            }
            function populateItemUi(data) {
              scope.item = data;

              scope.item.isEditMode  =true;
              scope.frmInventoryItem.$setDirty();
              scope.picture  = scope.item.pictureUrl;
              // find category that matches the current item category
              scope.$parent.pageTitle  = "Edit " +scope.item.name;
              scope.category.name = scope.item.categoryId;
              var res  = _.findWhere(scope.categories, {name : scope.item.categoryId});
              scope.category  = res;

            }
            function getItemById(id) {
              scope.uiMode.isDisabled = true;
              scope.loading  = true;
              ItemService.getItem(id)
                .then(function (response) {
                  scope.loading  = false;
                  if (response.data.success) {
                    populateItemUi(response.data.data);
                    // let get the stock history data
                    _.map(scope.item.storageType, function (st) {
                      if(!scope.item.isServiceItem )
                      {
                        getStockHistoryFor(st);
                      }

                    });
                    if (!angular.isDefined(scope.category))
                    {
                      scope.category = {
                        name :null,
                        isChild : false,
                        id  :null
                      };
                    }
                    ////(scope.item);
                  }
                  else {
                    var valErrors = response.data.validationErrors.errorLogs,
                      msg = "<p>" + response.data.message + "</p>";
                    if (valErrors.length > 0) {
                      msg += "<ul >";
                      angular.forEach(valErrors, function (obj) {
                        msg += "<li>" + obj.fieldName + " --> <b>" + obj.hint + "</b>";
                      });
                      msg += "</ul>";
                    }

                    Toast.pullDown(msg, false, 7000, 'bg-danger');
                  }


                }, function (status) {
                  scope.loading = false;
                  Toast.pullUp("Server Error");
                });
            }

            // function init(){
            //   // check if we are in Edit Mode here
            //   if(stateParams.mode ==1)
            //   {
            //     getItemById(stateParams.id);
            //   }
            // }
            //
            // init();
            scope.uploadPicture = function(obj)
            {
              scope.loading = true;
              fileUploadService.onFileUploadChange(obj, function (response) {
                //
                if(response.success)
                {
                  scope.picture= response.files[0].autoFileUrl;

                  //Toast.pullDown(angular.toJson(response, true),true);
                  scope.hasImage =true;
                  scope.item.pictureUrl  = response.files[0].name;
                  scope.loading = false;
                  scope.$apply();
                }
              });
            }

            scope.createNewItem  = createNewItem;


            scope.resetForm = resetForm;
            scope.deleteItem = deleteItem;
            function deleteItem() {

                scope.loading = true;
                ItemService.deleteItem(scope.item)
                  .then(function(response){

                    scope.loading= false;
                    if(response.data.success)
                    {
                      //Toast.debug(response.data);
                      // Clean up the form :
                      Toast.pullDown("<p class='font-size-16'>" +response.data.message + "</p>");
                      resetForm();


                    }
                    else{
                      Toast.pullUp(response.data.message, false , 10000);
                    }
                    // Inform the ItemController list that the item was deleted
                    var uiResult  = {
                      success  : response.data.success,
                      action : 0 ,// Delete = 0 , Update = 1
                      data : response.data.data,
                      message  : response.data.message
                    };
                    $modalInstance.close(uiResult);
                    scope.loading = false;
                  });




            }
            scope.copyItem  = copyItem;
            function copyItem() {
              if (scope.item.isEditMode)
              {
                var copiedItem  =  angular.copy(scope.item);
                copiedItem.isEditMode  = false;
                _.map(copiedItem.storageType, function (s) {
                  s.isEditMode  = false;
                  s.id = null;
                });
                copiedItem.id = copiedItem.id+"_copy";
                scope.item = copiedItem;
                scope.frmInventoryItem.$setDirty();
                scope.uiMode.isDisabled = false;
              }
            }
            function resetForm() {
              scope.item = angular.copy(itemModel);
              scope.frmInventoryItem.$setPristine();
              scope.uiMode.isDisabled = false;
            }
            scope.cancelEditMode = cancelEditMode;
            var tempData  = {};
            function cancelEditMode()
            {
              scope.uiMode.isDisabled=true;
              scope.item  = tempData;//angular.copy(tempData);
              tempData  = {};

            }
            //TODO Create NEW Inventory Item

            // Toast.pullDown("<p class='font-size-26'>My Name Is Somtochukwu <br>I Love Programming</p>", true);

            function createNewItem()
            {
              // check if we are in edit Mode
              if (scope.uiMode.isDisabled)
              {
                // set it to enabled
                scope.uiMode.isDisabled = false;
                tempData  = angular.copy(scope.item);
                return;
              }

              if (scope.frmInventoryItem.$valid && scope.frmInventoryItem.$dirty){
                scope.loading= true;
                // Toast.debug(scope.category);
                scope.item.categoryId  = angular.isDefined(scope.category) ? scope.category.name  : null;
                // return;
                //alert(scope.item.categoryId);
                // check for EditMode
                if (scope.item.isEditMode)
                {
                  // We have to perform updates here instead of creating a new item
                  // storage types are ignored on the server

                  ItemService.updateItem(scope.item)
                    .then(function(response){

                      scope.loading= false;
                      if(response.data.success)
                      {
                        //Toast.debug(response.data);
                        // Clean up the form :
                        Toast.pullDown(response.data.message);
                        scope.uiMode.isDisabled = true;
                        scope.item.isUpdated  = true;
                      }
                      else{
                        Toast.pullUp(response.data.message,false,  9000, 'bg-danger');
                        scope.item.isUpdated  = false;
                      }
                      // Inform the ItemController list that the item was deleted
                      var uiResult  = {
                        success  : response.data.success,
                        action : 1 ,// Delete = 0 , Update = 1
                        data : scope.item,
                        message  : response.data.message
                      };

                      $modalInstance.close(uiResult);

                    });
                  // if successful


                }
                else{

                  // Let check is the user doesn't want sub Items to be stored
                  if(scope.item.storageType.length == 0)
                  {
                    // check if we have the settings for sub Items enabled
                    if(scope.appSettings.useSubItems)
                    {
                      // alert user that they didn't enter a storage Type
                      Toast.pullDown("<p class='font-size-16'>You did not specify sub Items for this Item. you can edit the setting " +
                        "in the settings Menu > Other Settings section </p>",  true, 10000);
                      scope.loading= false;
                      return  ; //  terminate here!

                    }
                    else{
                      // simply add the item dynamically
                      var st   =  angular.copy(scope.storageType);
                      st.description  = scope.item.name;
                      st.itemId  = scope.item.id;
                      if(st.retailPrice  < 0 ){st.retailPrice  = 0;}
                      scope.item.storageType = [];
                      scope.item.storageType.push(st);
                    }

                  }
                  // Create new item
                  ItemService.addNewItem(scope.item)
                    .then(function(response){

                      scope.loading= false;
                      if(response.data.success)
                      {
                        //Toast.debug(response.data);
                        // Clean up the form :
                        Toast.pullDown(response.data.message);
                        // populateItemUi(response.data.data);
                        resetForm();
                      }
                      else{
                        Toast.pullUp(response.data.message, false, 6000, 'bg-danger');
                      }

                    });
                }

              }
              else{
                Toast.pullUp("Please fill in the required Fields");
              }
            }
            function getAppSettings()
            {
              OrgInfoService.getSettings()
                .then(function (response) {
                  if(response.data.success)
                  {
                    scope.appSettings  = response.data.data;
                    scope.storageType.retailPrice=scope.appSettings.useDefaultItemSalesAmount ? scope.appSettings.defaultItemSalesAmount : 0.0;

                  }
                });
            }

            getAppSettings();
            scope.closeDialog=  function () {
              $modalInstance.dismiss();
            }
          }




})();

