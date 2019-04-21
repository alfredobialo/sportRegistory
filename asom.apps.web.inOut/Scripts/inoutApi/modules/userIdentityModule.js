/**
 * Created by USER on 4/2/2016.
 */
(function(ng,window){
    var user  = ng.module("userIdentityModule", [] );

    user.controller("UserIdentityController", ["$scope","IdentityService","FileUploadService", UserIdentityController])
      .controller("LoginViewController",["$scope", "IdentityService",LoginViewController])
      .controller("MyProfileManagerController",  ["$scope","$rootScope", "IdentityService", MyProfileManagerController])
      .controller("UserManagerController",  ["$scope","$rootScope", "IdentityService","OrgInfoService", "FileUploadService", "RoleManagerService", UserManagerController])
      .controller("RegisteredUserManagerController",  ["$scope","$rootScope","$stateParams", "IdentityService","OrgInfoService", "FileUploadService", "RoleManagerService","DialogService", RegisteredUserManagerController])
      .controller("RoleManagerController",  ["$scope", "IdentityService",  "RoleManagerService", RoleManagerController])
        .controller("RegistrationController", ["$scope", "IdentityService", RegistrationController])
      .controller("ForgotPasswordController", ["$scope", "IdentityService", ForgotPasswordController])
      .factory("RoleManagerService", ["$http", RoleManagerService])
        .factory("IdentityService", ["$http", IdentityService]);


  function ForgotPasswordController(scope, IdentityService) {

    scope.emailPattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    scope.processing = false;
    scope.done = false;
    scope.resetPassword = resetPassword;
    function resetPassword(userInfo) {
      scope.processing = true;
      IdentityService.forgotPasswordProcess(userInfo.userId, userInfo.email)
        .then(function (response) {
          console.log(response);
          if (response.data.success) {
            scope.done = true;
            Toast.pullUp(response.data.message);
          }
          else {
            Toast.pullDown(effectiv.getValidationTemplate(response.data), true, 6000, "bg-danger");
          }
          scope.processing = false;
        })
    }


  }

  function MyProfileManagerController(scope, rootScope, IdentityService) {
    scope.currentUser = rootScope.currentUser;
    scope.changePassword = changePassword;
    scope.processing = false;
    scope.criteria = IdentityService.getCriteriaModel;
    scope.identitModel = IdentityService.getModel;
    scope.updateProfile = function () {
      scope.criteria.id = scope.currentUser.userId;

      scope.criteria.updateDisplayName = true;
      scope.criteria.updateEmail = true;

      scope.loading = true;

      IdentityService.updateFields(scope.currentUser, scope.criteria)
        .then(function (response) {
          if (response.data.success) {
            // if(response.data.validationMessage.errors.length>0)
            // {
            //   alert("We have error!");
            // }
            Toast.pullDown(response.data.message, false, 7000);
            scope.criteria.updateDisplayName = false;
            scope.criteria.updateEmail = false;
            scope.editMode = false;
          }
          else {
            Toast.pullUp(effectiv.getValidationTemplate(response.data), true, 4000, "bg-danger");
          }
          scope.loading = false;

        });

    };
    function changePassword(oldPwd, newPwd, newPwd2) {
      // check for match then go change password
      if (!_.isEmpty(oldPwd) && !_.isEmpty(newPwd) && !_.isEmpty(newPwd2)) {
        if (newPwd === newPwd2) {
          scope.processing = true;
          IdentityService.updateUserPassword(scope.currentUser.id, oldPwd, newPwd)
            .then(function (response) {
              scope.processing = false;
              console.log(response);
              if (response.data.success) {
                Toast.pullUp("<p class='font-size-14'>Password Change was successful. Congrats!!!</p>");
              }
              else {
                Toast.pullDown(effectiv.getValidationTemplate(response.data), true, 670, 'bg-danger');
              }
            });
        }
        else {
          Toast.pullDown("<p class='font-size-14'>New Password didn't match correctly</p>", false, 5000, 'bg-danger');
        }

      }
      else {
        Toast.pullDown("<p class='font-size-14'>Please Enter all Password Field correctly before proceeding!</p>", false, 5000, 'bg-danger');
      }


    }

  }
  
    function UserManagerController(scope,rootScope, IdentityService,OrgInfoService, FileUploadService, RoleManagerService) {
      scope.users = [];
      scope.channels  = [];
      scope.profilePicture  = null;
      scope.accountType = ["SYSADMIN","SYSCHANNEL", "SYSUSER"];

      scope.loading  = false;
      scope.userInfo = rootScope.currentUser;
      // scope.users.push(rootScope.currentUser);
      scope.$watchCollection("users", function (iobj) {
          _.map(scope.users, function (obj) {
            obj.passportUrl  =  {'background-image': 'url('+obj.pictureUrl+')'};
          });
      });
      scope. uploadPicture  = upload;
      function upload(obj) {
        scope.loading  = true;
          FileUploadService.onFileUploadChange(obj , function (response) {
            //(response)
              if(response.success)
              {
                scope.passport  = {'background-image': 'url('+response.files[0].autoFileUrl+')'};
                // if(scope.uiMode.canCreateNew)
                // {
                //
                // }
                scope.profilePicture  = response.files[0].name;
                scope.userInfo.pictureUrl = response.files[0].name;
                scope.loading  = false;
                scope.$apply();
              }
              else{
                  Toast.pullDown("<p class='font-size-16'>"+ response.errorMessage+" </p>");
              }

          })
      }
      scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};
      scope.selectedUser  =  IdentityService.getModel;
      scope.userCriteria = IdentityService.getCriteriaModel;
      scope.userCriteria.loadOnlyAdmin  = true;
      scope.roles  = [];
      scope.loadRoles = loadRoleNames;
      scope.selectRole  = selectRole;
      scope.editUser  = editUser;
      scope.cancelEdit  = cancelEdit;
      scope.viewPassword  = function (currentUser, urPassword) {
          scope.loadingPassword  = true;

          IdentityService.getUserPassword(currentUser.userId, urPassword)
            .then(function (response) {
              scope.loadingPassword  = false;
                //(response);
                if(response.data.success)
                {
                    currentUser.password = response.data.data;
                }
                else{
                  Toast.pullDown("<p class='font-size-16 text-left'>" +response.data.message+"</p>",false,7000 ,"bg-danger");
                }
            })
      }
      var uiMode   = {
        canCreateNew   : false,
        canCancel  : false
      };
      scope.uiMode =  {
        canCreateNew   : false,
        canCancel  : false
      };
      scope.defPicture = null;
      scope.createNewUserMode  = function () {
        scope.uiMode.canCreateNew  =  true;
        scope.uiMode.canCancel  = true;
        scope.userInfo.isEditMode = false;
        scope.userInfo  = {};
        scope.userInfo.objType = "SYSUSER";
        // deselect roles
        deselectRoles();
        // set the display picture to null and transparent

        scope.passport  = {'background-image': 'url('+scope.defPicture+')'};
      }
      scope.saveNewUserMode  = function (userInfo, urPassword) {

        // Validate Input and Hit the server
        //   //(getSelectedRoles());
        //  Connect to server
        if(countSelectedRoles()>0)
        {

          scope.loading  = true;
          userInfo.pictureUrl  = scope.profilePicture;
          var tempUser  = IdentityService.getModel;
          tempUser.password  = userInfo.password;
          tempUser.userId  = userInfo.id;
          tempUser.id  = userInfo.id;
          tempUser.pictureUrl   = userInfo.pictureUrl;
          tempUser.objType  = userInfo.objType;
          tempUser.channelId  = userInfo.channelId;
          tempUser.displayName  = userInfo.displayName;
          tempUser.gender  = "male";

          IdentityService.createUserAccount(tempUser, getSelectedRoles(), urPassword)

              .then(function (response) {
                scope.loading  = false;
                  //(response);
                  if(response.data.success)
                  {
                      Toast.showSuccess("Created Successfully!", response.data.message);
                      scope.users.push(response.data.data);
                      scope.uiMode.canCreateNew  =  false;
                      scope.uiMode.canCancel  = false;
                      scope.profilePicture  = null;
                      scope.userInfo  = {};
                      deselectRoles();
                      scope.passport  = {'background-image': 'url('+scope.defPicture+')'};
                      Toast.closePullDown();
                      Toast.closePullUp();
                      // reset ui
                  }
                  else{

                   Toast.pullUp(effectiv.getValidationTemplate(response.data), true,7000,"bg-danger") ;
                }
              });
        }
        else {
          Toast.pullDown("<p class='font-size-16'>Please select at least one 'System Roles'</p>", false, 8000, 'bg-danger');

        }

      }
      scope.cancelMode  = function () {
        scope.uiMode.canCreateNew  =  false;
        scope.uiMode.canCancel  = false;
        scope.passport  = {'background-image': 'url('+scope.defPicture+')'};

      }
      var temp  = {};
      function cancelEdit (userInfo)
      {
          if(userInfo.isSelected && userInfo.isEditMode)
          {
            // cancel edit mode
            userInfo  = angular.copy(temp);
            deselectUser(userInfo);
            temp  = {};
          }
      }

      function deselectUser(userInfo) {
        userInfo.isSelected  = false;
      }
      function editUser(userInfo) {
        scope.cancelMode();
        scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};
        temp  = angular.copy(userInfo);
        Toast.showInfo("User Account Selected",userInfo.displayName + " Selected! and ready for modifications");
        _.map(scope.users, function (x) {
          x.isSelected=false;
        });
        scope.userInfo  = temp;
        selectUserRoles(userInfo);
        userInfo.isSelected  = true;
        scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};

      }

      function selectUserRoles(userInfo)
      {
        deselectRoles();
          // select the roles to which the selected user belongs
          _.map(scope.roles, function (r) {
             var index  =  _.findIndex(r.users, {id : userInfo.id});

              if(index > -1)
              {
                // found , select the role
                // Toast.showSuccess("Role Found", userInfo.displayName + " is in " + r.name +" Role");

                selectRole(r);
              }
          })
      }
      scope.myRoles  = [];
      function selectMyRoles(userInfo)
      {
        scope.myRoles  = [];
        // select the roles to which the selected user belongs
        _.map(scope.roles, function (r) {
          var index  =  _.findIndex(r.users, {id : userInfo.id})
          if(index > -1)
          {
              scope.myRoles.push(r);
          }
        })
      }
      function loadBusinessChannels()
      {
        scope.channels = [];
        OrgInfoService.getBusinessChannels()
          .then(function (response) {
            if(response.data.success)
            {
              _.map(response.data.data, function (c) {
                scope.channels.push(c.id);
              });


            }

          }, function(response)
          {
              // Error occured on server
              Toast.pullDown(response.statusText);
          });

      }
       // called on init if current user is an admin user
      function selectRolesByUser(user)
      {
        // We should select all roles in which a
        // user is assigned when user is selected
      }
      function deselectRoles(){
        _.map(scope.roles, function (r) {
          r.isSelected = false;
        });
      }

      function countSelectedRoles()
      {
        var selectedRoles  = getSelectedRoles();
        return selectedRoles.length;
      }
      function getSelectedRoles() {
       var roles  =  _.where(scope.roles, {
          isSelected : true});
          return roles;
      }


      function selectRole(role)
      {
        // deselect other roles if the selected role is an admin role


        if(role.isAdmin)
        {
          deselectRoles();
        }
        else{
          _.map(scope.roles, function (r) {
            if(r.isAdmin)
            {
              r.isSelected = false;
            }

          });
        }
        role.isSelected = ! role.isSelected || false ;

      }
      function loadRoleNames() {
        scope.loadingRoles  = true;
        RoleManagerService.getAllSysRolesName()
          .then(function (response) {
            scope.loadingRoles  = false;
            if(response.data.success)
            {
              scope.roles  = response.data.data;
              selectMyRoles(scope.userInfo);
            }
            else{
              Toast.pullUp(response.message, false, 7000, 'bg-danger');
            }
          })
      }

      scope.loadUsers  = loadUsers;
      function loadUsers() {
        scope.loading  = true;
        IdentityService.getUsers(scope.userCriteria)
          .then(function (response) {
            scope.loading  = false;

              if(response.data.success)
              {
                  scope.users  = response.data.data;
                //(scope.users);
                  scope.userCriteria  = response.data.criteria;
              }

          })
      }
    scope.gotoPage = function(index)
    {
        scope.userCriteria.currentPage  = index;
        loadUsers();
    };
      scope.refresh = init;
      function init() {
        loadRoleNames();
        loadUsers();
        loadBusinessChannels();
      }
    init();
    }

  function RegisteredUserManagerController(scope,rootScope,$stateParams, IdentityService,OrgInfoService, FileUploadService, RoleManagerService ,  DialogService) {
    scope.users = [];
    scope.channels  = [];
    scope.profilePicture  = null;
    scope.accountType = ["SYSADMIN","SYSCHANNEL", "SYSUSER"];

    scope.loading  = false;
    scope.userInfo = rootScope.currentUser;
    // scope.users.push(rootScope.currentUser);
    scope.$watchCollection("users", function (iobj) {
      _.map(scope.users, function (obj) {
        obj.passportUrl  =  {'background-image': 'url('+obj.pictureUrl+')'};
      });
    });
    scope. uploadPicture  = upload;
    function upload(obj) {
      scope.loading  = true;
      FileUploadService.onFileUploadChange(obj , function (response) {
        //(response)
        if(response.success)
        {
          scope.passport  = {'background-image': 'url('+response.files[0].autoFileUrl+')'};
          // if(scope.uiMode.canCreateNew)
          // {
          //
          // }
          scope.profilePicture  = response.files[0].name;
          scope.userInfo.pictureUrl = response.files[0].name;
          scope.loading  = false;
          scope.$apply();
        }
        else{
          Toast.pullDown("<p class='font-size-16'>"+ response.errorMessage+" </p>");
        }

      })
    }
    scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};
    scope.selectedUser  =  IdentityService.getModel;
    scope.userCriteria = IdentityService.getCriteriaModel;
    scope.userCriteria.includeAdmin  =false;
    scope.userCriteria.loadOnlyAdmin  =false;
    scope.roles  = [];
    scope.loadRoles = loadRoleNames;
    scope.selectRole  = selectRole;
    scope.editUser  = editUser;
    scope.cancelEdit  = cancelEdit;
    scope.sessionPassword = null;
    scope.showPwdDialog  = true;
    scope.viewPassword  = function (currentUser) {
      if(scope.showPwdDialog)
      {
        DialogService.openPasswordInputDialog("Enter Password" , "Please Reenter your Login Password Here to continue! before Viewing " + currentUser.displayName + " password", "Get Password","Cancel",function (password) {

          scope.sessionPassword  = password;
          scope.loadingPassword  = true;

          IdentityService.getUserPassword(currentUser.userId, scope.sessionPassword)
            .then(function (response) {
              scope.loadingPassword  = false;
              //(response);
              if(response.data.success)
              {
                currentUser.password = response.data.data;
                scope.showPwdDialog  = false;
              }
              else{
                Toast.pullDown("<p class='font-size-16 text-left'>" +response.data.message+"</p>",false,7000 ,"bg-danger");
                scope.showPwdDialog  = true;
              }
            });
        });
      }
      else if( !scope.showPwdDialog  &&   _.isEmpty(scope.sessionPassword) == false)
      {
        IdentityService.getUserPassword(currentUser.userId, scope.sessionPassword)
          .then(function (response) {
            scope.loadingPassword  = false;
            //(response);
            if(response.data.success)
            {
              currentUser.password = response.data.data;
              scope.showPwdDialog  = false;
            }
            else{
              Toast.pullDown("<p class='font-size-16 text-left'>" +response.data.message+"</p>",false,7000 ,"bg-danger");
              scope.showPwdDialog  = true;
            }
          });
      }



    };

    /*  BLOCK un block User  */
    scope.performBlockAction  = performBlockAction;
    function performBlockAction(userInfo) {
      // This user id will send to the server with a string to in form the server on what to do
      if(scope.showPwdDialog){
        DialogService.openPasswordInputDialog("Enter Password" ,
          "Please Reenter your Login Password Here to continue! before Modifying " + userInfo.displayName + " Login Account",
          "Get Password","Cancel",function (password) {

            scope.sessionPassword = password;
            if(userInfo.isBlocked)
            {
              // we want to unblock  the user so confirm the user's action
              DialogService.openDialog("Confirm Un-blocking user",
                userInfo.displayName + " is currently Blocked, this action will UNBLOCK this account! and " + userInfo.displayName + " will have access to services on this platform, DO you want to Proceed?",
                "Unblock Account", "Cancel", function () {

                  // This is where we Unblock the User Account
                  IdentityService.unBlockUserAccount(userInfo.id, scope.sessionPassword)
                    .then(function (response) {
                      if(response.data.success)
                      {
                        userInfo.isBlocked = false;
                        scope.showPwdDialog   = false;
                        Toast.pullUp(response.data.message);
                      }
                      else{
                        Toast.pullUp(response.data.message, false, 8000, 'bg-danger');
                        scope.showPwdDialog   = true;
                      }
                    });

                }
              );
            }
            else
            {
              // we want to unblock  the user so confirm the user's action
              DialogService.openDialog("Confirm Blocking user",
                userInfo.displayName + " is currently NOT BLOCKED, this action will BLOCK this account! from accessing this platform, DO you want to Proceed? ",
                "Block Account", "Cancel", function () {
                  IdentityService.blockUserAccount(userInfo.id, scope.sessionPassword)
                    .then(function (response) {
                      if(response.data.success)
                      {
                        userInfo.isBlocked = true;
                        Toast.pullUp(response.data.message);
                        scope.showPwdDialog   = false;
                      }
                      else{
                        Toast.pullUp(response.data.message, false, 8000, 'bg-danger');
                        scope.showPwdDialog   = true;
                      }
                    });

                }
              );
            }



            //scope.loadingPassword = true;
          });
      }
      else if(!scope.showPwdDialog  &&   _.isEmpty(scope.sessionPassword) == false)
      {
        if(userInfo.isBlocked)
        {
          // we want to unblock  the user so confirm the user's action
          DialogService.openDialog("Confirm Un-blocking user",
            userInfo.displayName + " is currently Blocked, this action will UNBLOCK this account! and " + userInfo.displayName + " will have access to services on this platform, DO you want to Proceed?",
            "Unblock Account", "Cancel", function () {

              // This is where we Unblock the User Account
              IdentityService.unBlockUserAccount(userInfo.id, scope.sessionPassword)
                .then(function (response) {
                  if(response.data.success)
                  {
                    userInfo.isBlocked = false;
                    scope.showPwdDialog   = false;
                    Toast.pullUp(response.data.message);
                  }
                  else{
                    Toast.pullUp(response.data.message, false, 8000, 'bg-danger');
                    scope.showPwdDialog   = true;
                  }
                });

            }
          );
        }
        else
        {
          // we want to unblock  the user so confirm the user's action
          DialogService.openDialog("Confirm Blocking user",
            userInfo.displayName + " is currently NOT BLOCKED, this action will BLOCK this account! from accessing this platform, DO you want to Proceed? ",
            "Block Account", "Cancel", function () {
              IdentityService.blockUserAccount(userInfo.id, scope.sessionPassword)
                .then(function (response) {
                  if(response.data.success)
                  {
                    userInfo.isBlocked = true;
                    Toast.pullUp(response.data.message);
                    scope.showPwdDialog   = false;
                  }
                  else{
                    Toast.pullUp(response.data.message, false, 8000, 'bg-danger');
                    scope.showPwdDialog   = true;
                  }
                });

            }
          );
        }
      }



    }



    var uiMode   = {
      canCreateNew   : false,
      canCancel  : false
    };
    scope.uiMode =  {
      canCreateNew   : false,
      canCancel  : false
    };
    scope.resetSearch = function () {
      scope.userCriteria.queryString = null;
      scope.userCriteria.currentPage  = 1;
      loadUsers();
    };
    scope.doUiSearch  = uiSearch;
    function uiSearch(evt)
    {

      if(scope.frmSearch.$valid && scope.frmSearch.$dirty)
      {
        if(evt.keyCode == 13){
          // Enter key
          //search
          scope.userCriteria.currentPage  = 1;
          loadUsers();
        }
      }
      else {
        Toast.pullDown("Please enter a search criteria");
      }
    }
    scope.defPicture = null;
    scope.createNewUserMode  = function () {
      scope.uiMode.canCreateNew  =  true;
      scope.uiMode.canCancel  = true;
      scope.userInfo.isEditMode = false;
      scope.userInfo  = {};
      scope.userInfo.objType = "SYSUSER";
      // deselect roles
      deselectRoles();
      // set the display picture to null and transparent

      scope.passport  = {'background-image': 'url('+scope.defPicture+')'};
    }
    scope.saveNewUserMode  = function (userInfo, urPassword) {

      // Validate Input and Hit the server
      //   //(getSelectedRoles());
      //  Connect to server
      if(countSelectedRoles()>0)
      {

        scope.loading  = true;
        userInfo.pictureUrl  = scope.profilePicture;
        var tempUser  = IdentityService.getModel;
        tempUser.password  = userInfo.password;
        tempUser.userId  = userInfo.id;
        tempUser.id  = userInfo.id;
        tempUser.pictureUrl   = userInfo.pictureUrl;
        tempUser.objType  = userInfo.objType;
        tempUser.channelId  = userInfo.channelId;
        tempUser.displayName  = userInfo.displayName;
        tempUser.gender  = "male";

        IdentityService.createUserAccount(tempUser, getSelectedRoles(), urPassword)

          .then(function (response) {
            scope.loading  = false;
            //(response);
            if(response.data.success)
            {
              Toast.showSuccess("Created Successfully!", response.data.message);
              scope.users.push(response.data.data);
              scope.uiMode.canCreateNew  =  false;
              scope.uiMode.canCancel  = false;
              scope.profilePicture  = null;
              scope.userInfo  = {};
              deselectRoles();
              scope.passport  = {'background-image': 'url('+scope.defPicture+')'};
              Toast.closePullDown();
              Toast.closePullUp();
              // reset ui
            }
            else{

              Toast.pullUp(effectiv.getValidationTemplate(response.data), true,7000,"bg-danger") ;
            }
          });
      }
      else {
        Toast.pullDown("<p class='font-size-16'>Please select at least one 'System Roles'</p>", false, 8000, 'bg-danger');

      }

    }
    scope.cancelMode  = function () {
      scope.uiMode.canCreateNew  =  false;
      scope.uiMode.canCancel  = false;
      scope.passport  = {'background-image': 'url('+scope.defPicture+')'};

    }
    var temp  = {};
    function cancelEdit (userInfo)
    {
      if(userInfo.isSelected && userInfo.isEditMode)
      {
        // cancel edit mode
        userInfo  = angular.copy(temp);
        deselectUser(userInfo);
        temp  = {};
      }
    }

    function deselectUser(userInfo) {
      userInfo.isSelected  = false;
    }
    function editUser(userInfo) {
      scope.cancelMode();
      scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};
      temp  = angular.copy(userInfo);
      Toast.showInfo("User Account Selected",userInfo.displayName + " Selected! and ready for modifications");
      _.map(scope.users, function (x) {
        x.isSelected=false;
      });
      scope.userInfo  = temp;
      selectUserRoles(userInfo);
      userInfo.isSelected  = true;
      scope.passport  = {'background-image': 'url('+scope.userInfo.pictureUrl+')'};

    }

    function selectUserRoles(userInfo)
    {
      deselectRoles();
      // select the roles to which the selected user belongs
      _.map(scope.roles, function (r) {
        var index  =  _.findIndex(r.users, {id : userInfo.id});

        if(index > -1)
        {
          // found , select the role
          // Toast.showSuccess("Role Found", userInfo.displayName + " is in " + r.name +" Role");

          selectRole(r);
        }
      })
    }
    scope.myRoles  = [];
    function selectMyRoles(userInfo)
    {
      scope.myRoles  = [];
      // select the roles to which the selected user belongs
      _.map(scope.roles, function (r) {
        var index  =  _.findIndex(r.users, {id : userInfo.id})
        if(index > -1)
        {
          scope.myRoles.push(r);
        }
      })
    }
    function loadBusinessChannels()
    {
      scope.channels = [];
      OrgInfoService.getBusinessChannels()
        .then(function (response) {
          if(response.data.success)
          {
            _.map(response.data.data, function (c) {
              scope.channels.push(c.id);
            });


          }

        }, function(response)
        {
          // Error occured on server
          Toast.pullDown(response.statusText);
        });

    }
    // called on init if current user is an admin user
    function selectRolesByUser(user)
    {
      // We should select all roles in which a
      // user is assigned when user is selected
    }
    function deselectRoles(){
      _.map(scope.roles, function (r) {
        r.isSelected = false;
      });
    }

    function countSelectedRoles()
    {
      var selectedRoles  = getSelectedRoles();
      return selectedRoles.length;
    }
    function getSelectedRoles() {
      var roles  =  _.where(scope.roles, {
        isSelected : true});
      return roles;
    }


    function selectRole(role)
    {
      // deselect other roles if the selected role is an admin role


      if(role.isAdmin)
      {
        deselectRoles();
      }
      else{
        _.map(scope.roles, function (r) {
          if(r.isAdmin)
          {
            r.isSelected = false;
          }

        });
      }
      role.isSelected = ! role.isSelected || false ;

    }
    function loadRoleNames() {
      scope.loadingRoles  = true;
      RoleManagerService.getAllSysRolesName()
        .then(function (response) {
          scope.loadingRoles  = false;
          if(response.data.success)
          {
            scope.roles  = response.data.data;
            selectMyRoles(scope.userInfo);
          }
          else{
            Toast.pullUp(response.message, false, 7000, 'bg-danger');
          }
        })
    }

    scope.loadUsers  = loadUsers;
    function loadUsers() {
      scope.loading  = true;
      IdentityService.getUsers(scope.userCriteria)
        .then(function (response) {
          scope.loading  = false;

          if(response.data.success)
          {
            scope.users  = response.data.data;
            //(scope.users);
            scope.userCriteria  = response.data.criteria;
          }

        })
    }
    scope.gotoPage = function(index)
    {
      // if(index == scope.userCriteria.currentPage)
      // {
      //   return;
      // }
      scope.userCriteria.currentPage  = index;
      loadUsers();
    };
    scope.refresh = init;
    function init() {
     // loadRoleNames();
      console.log($stateParams);
      if(!_.isEmpty($stateParams.q))
      {
        scope.userCriteria.queryString  = $stateParams.q;
        scope.userCriteria.currentPage  = 1;
        loadUsers();
      }
      else{
        loadUsers();
      }


      //loadBusinessChannels();
    }
    init();

    scope.showDetails  =  function(ticket)
    {
      ticket.showParties  = !ticket.showParties;
      _.map(ticket.parties, function(obj)
      {
        obj.isPh  = ticket.ticketType == 2;
        obj.isBtc  = ticket.group == "BITCOIN";

        // if we havent't load the current user details, please let do that now
        if(!obj.userInfo)
        {
          obj.loadingUserInfo = true;
          obj.userBankInfo = {
            banks: [],
            bitcoins  : []
          };

          IdentityService.getUser(obj.partyId)
            .then(function (response) {
              if(response.data.success)
              {
                obj.userInfo  = response.data.data;
                obj.userInfo.photo =   {'background-image': 'url('+obj.userInfo.pictureUrl+')'};
                var prefKey = 'bank_criteria', prefKey2  = "bitcoin_criteria";
                var pref  = _.findWhere(obj.userInfo.preferences, { 'prefKey' : prefKey});
                var pref2  = _.findWhere(obj.userInfo.preferences, { 'prefKey' : prefKey2});






                function init()
                {
                  try{
                    if(!_.isEmpty(pref.prefValue))
                    {
                      // We found it
                      try {
                        obj.userBankInfo.banks = angular.fromJson(pref.prefValue);
                      }
                      catch (err) {
                        // just reset the obj to empty
                        pref.prefValue  = angular.toJson(obj.userBankInfo.banks)
                      }
                    }
                    else {
                      // set the preference for the bank to an empty array
                      pref.prefValue  = angular.toJson(obj.userBankInfo.banks)

                    }
                    if(!_.isEmpty(pref2.prefValue)) {
                      // We found it
                      try {
                        obj.userBankInfo.bitcoins = angular.fromJson(pref2.prefValue);
                      }
                      catch (err) {
                        // just reset the obj to empty
                        pref2.prefValue  = angular.toJson(obj.userBankInfo.bitcoins)
                      }
                    }
                    else {
                      // set the preference for the bank to an empty array
                      pref2.prefValue  = angular.toJson(obj.userBankInfo.bitcoins);
                    }
                    //(scope.userBankInfo);

                  }
                  catch (err){
                    Toast.pullUp("An Error occurred, please reload this page!");
                  }
                  // for bitcoin

                }
                init();
              }
              else{
                Toast.showInfo("Issue Loading User Record", response.data.message,7000);Toast.showInfo("Loading User Record", "Please wait for eternity for this process to complete!",7000);
              }
              obj.loadingUserInfo = false;

            });
        }
        // so we need the identity  Service in this case


      });
    };
    scope.hideShowUserInfo  =hideShowUserInfo ;
    function hideShowUserInfo(user) {
        user.isSelected  = !user.isSelected;

          user.phTickets = user.phTickets || [];
          user.ghTickets = user.ghTickets || [];

          user.phCriteria = user.phCriteria || {
             currentPage  : 1,
             pageSize  :10 };
          user.ghCriteria = user.phCriteria || {
          currentPage  : 1,
          pageSize  :10 };
        if(user.phTickets.length==0)
        {

            getPhTicket(user);
        }
        if(user.ghTickets.length==0)
        {

          getGhTicket(user);
        }
    };

/*
 *  User TicketProfile
 *
 */

    // scope.loadingPhTickets = false;
    // scope.getPhTicket = getPhTicket;
    // // scope.phCriteria  = {
    // //   currentPage : 1,
    // //   pageSize : 10
    // // };
    // scope.phTickets = [];
    function getPhTicket(userInfo) {
      userInfo.loadingPhTickets = true;
      userInfo.phCriteria.id = userInfo.id;

        InOutTransactionService.getProvideHelpTicketByUser(userInfo.phCriteria)
          .then(function (response) {

              if (response.data.success) {

                userInfo.phTickets = response.data.data;
                userInfo.phCriteria = response.data.criteria;

              }
              else {
                  Toast.pullDown(response.data.message, false, 8000, "bg-danger");
              }
            userInfo.loadingPhTickets = false;
          });
    }
    function getGhTicket(userInfo) {
      userInfo.loadingGhTickets = true;
      userInfo.phCriteria.id = userInfo.id;

      InOutTransactionService.getGetHelpTicketByUser(userInfo.ghCriteria)
        .then(function (response) {

          if (response.data.success) {

            userInfo.ghTickets = response.data.data;
            userInfo.ghCriteria = response.data.criteria;

          }
          else {
            Toast.pullDown(response.data.message, false, 8000, "bg-danger");
          }
          userInfo.loadingGhTickets = false;
        });
    }

  }
    function RoleManagerController(scope, IdentityService, RoleManagerService) {
      scope.loading   =false;
      scope.roles  = [];
      // scope.searchText = null;
      scope.loadAllRoles  = getAllRoles;
      scope.currentRole = angular.copy(RoleManagerService.getRoleModel);
      scope.selectRole  = selectRole;
      // Lets work on Role Selection
      function selectRole(role) {
        // clear any selection
        _.map(role.permissions, function (p) {
          p.isSelected = false;
        });
        scope.currentRole = role;
      }


      function getAllRoles ()
      {
          scope.loading  = true;
           RoleManagerService.getAllSysRoles()
             .then(function (response) {
               scope.loading  = false;
                // this returns all roles
                if(response.data.success)
                {
                    // assign roles to scope
                    scope.roles  = response.data.data;
                  //Toast.pullDown("All Roles Loaded");
                }
                else{
                  Toast.pullUp("Request Failed!,  Please Check console for error details", true);
                  //(response);
                }
             },
             function (response) {
               scope.loading  = false;
               Toast.showError("REQUEST FAILED", "Could not complete your request on the server", 14000);
               //(response);

             }
             )

      }
      getAllRoles();
      // let define a role Model similar to what we have on the server
      // a function definition would be better, but am going to stick with object literals
  }
  // WELCOME, AM Alfred OBialo and a Software Developer at Asom Services
  // This video shows the design and Implementation of My Security Role ACCESS API
  // for Effectiv Business and Accounting manager
  // I will be building the services that communicate with the backend

  function RoleManagerService($http) {
    var url  =effectiv.urls.identityUrl,
      roleCriteriaModel = {
        getByGroupName :false,
        groupName :null,
        activeValue :true,
        getActiveRole :false,
        userId :null,
        getByUser :false,
        getSystemDefined :false,
        systemDefautValue :null,
        getCustomRoles :false,
        customRoleValue :null,
        currentPage  :1,
        pageSize : 200},
      roleModel = {
        name :null, // Similar to Key
        description :null,
        isExpired :false,
        expirationDate :null,
        isExpirable : false,
        permissions :[],
        isSystemDefined :false,
        users :[],
        userDetails:[],
        isAdmin :false,
        id :null,
        groupName :null,
        isActive :true,
  },
      rolePermissionModel  = {
     id :null,
    name :null,
    description :null,
    isExpirable :false,
    dateCreated :null,
    expiresOn :null,
    isActive :true
      };
      return {
          getRoleModel : roleModel,
          getRolePermissionModel : rolePermissionModel,
          getRoleCriteriaModel : roleCriteriaModel,
          getSysRolesWithCriteria : function (criteria) {
            criteria   = angular.toJson(criteria);
            return effectiv.http.getRequest($http, url, {key : 1000, criteria : criteria});
          },

          getAllSysRoles : function () {
           return effectiv.http.getRequest($http, url, {key : 1001, criteria : null});
          },
          getAllCustomRolePermission : function () {
          return effectiv.http.getRequest($http, url, {key : 3001});
        },
          getAllSysRolesName : function () {
          return effectiv.http.getRequest($http, url, {key : 1002, criteria : angular.toJson({getRoleNames  :true})});
        },
          createCustomRole  : function (roleModel, userPassword) {
            // This action will be called by the RoleProxy Provider
            // this is required to prevent unauthorized users from creating a role
            roleModel = angular.toJson(roleModel);
            return effectiv.http.postRequest($http, url, {key : 2000, data :roleModel,criteria : userPassword});

          },
        installApplicationRoles  : function () {
          return $http.post(url, {key : 3000});

        }
          // lets stop here for now and see how the implementation goes on the server
      }
  }
    function LoginViewController(scope,identityService)
    {
        scope.userId = null;
        scope.password = null;
        scope.loading  = false;
        scope.remember  = false;
       scope.login  = function(evt)
       {
           evt.preventDefault();
           if(scope.frmLogin.$valid)
           {
             scope.loading  = true;
               //login using xhr
               identityService.authorizeUser({userId :scope.userId , password : scope.password, remember : scope.remember})
                   .then(function(response)
                   {
                     scope.loading  = false;
                       if(response.data.success)
                       {
                           evt.target.submit();
                       }
                       else{
                           Toast.pullDown("<p class=' text-left font-size-18'> Invalid User Id or Password Entered. Please note that " +
                                           "User id and password are case-sensitive and also check your CAP Lock key</p>" +
                             "<ul class='text-left pad10 margin-t-10 font-size-14'>Possible Cause :" +
                             "<li>Account Not Yet Activated. Ensure your account has been activated!</li>" +
                             "<li>Account BLOCKED. By not abiding to our policies your account may have been identified as RISK and blocked by our 'RULES MONITORING SYSTEM'</li>" +
                             "</ul>" +
                             "",true, 2000,"bg-danger" );
                       }
                   }, function(err)
                   {
                      Toast.pullUp(err.status);
                      scope.loading  = false;
                   });


           }
           else{
               Toast.pullDownInverse("Please Supply the required fields for this form" ,false ,10000);
           }

       }
    }

  function RegistrationController(scope,IdentityService)
  {
    scope.userInfo = {
      gender  : "Male"
    };


    scope.agreeToTerms = true;
    scope.password = null;
    scope.loading  = false;

    scope.emailPattern  = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    scope.countries  = [];
    function init() {
      IdentityService.getCountries()
        .then(function (response) {
          if(response.data.success)
          {

              scope.countries  = response.data.data;
          }

        })
    }
    init();

    scope.createAnother = function()
    {
        scope.showRegComplete  = false;
    }
    scope.processRegistration  = function(userInfo)
    {
      scope.loading = true;
      // check for valid record here
      IdentityService.registerNewUser(userInfo)
        .then(function (response) {
          scope.loading = false;
            if(response.data.success)
            {
                // we are successful
                scope.showRegComplete  = true;
                scope.userInfo={};
               // Toast.pullDown("<p class='font-size-18'>"+response.data.message+"</p>");


            }
            else{
              Toast.pullUp(effectiv.getValidationTemplate(response.data), true, 7000, "bg-danger");
              // Toast.pullUp("<p>"+ response.data.message+"</p>", true, 7000, "bg-danger");
            }

        });
    };

  }



    function UserIdentityController(scope,identityService, fileUploadService)
    {
        scope.userInfo = {
        };

        scope.$on("currentUserLoaded", function(evt, arg){
            scope.userInfo  = arg.currentUser;
        });
        scope.uploading  = false;
        scope.criteria  = identityService.getCriteriaModel;
        scope.identitModel  = identityService.getModel;
        scope.updateProfilePicture  =  function()
        {
            scope.criteria.id  = scope.userInfo.userId;
            scope.criteria.updateProfilePicture  = true;
            scope.identitModel.pictureUrl  = scope.userInfo.profilePicture;
            scope.identitModel.userId  = scope.userInfo.id;
            scope.identitModel.id  = scope.userInfo.id;
            identityService.updateFields(scope.identitModel,scope.criteria)
                .then(function(response){
                    if(!response.data.success)
                    {
                        Toast.pullDown(response.data.message, true,10000);
                    }
                    scope.uploading  = false;
                }, function(status)
                {
                    //(status);
                    scope.uploading  = false;
                });

        };
        scope.bgStyle = {};
        scope.profilePicture = null;
        scope.uploadPicture = function(obj) {

               scope.uploading  = true;
                scope.$apply();
                fileUploadService.onFileUploadChange(obj, function (result) {

                    //(result);
                    if(result.success)
                    {
                        scope.profilePicture = result.files[0].autoFileUrl;
                        scope.userInfo.profilePicture  = result.files[0].name;
                        scope.bgStyle  = {'background-image' : "url('"+scope.profilePicture+"')"};

                        //scope.criteria.tag.pictureUrl = scope.userInfo.profilePicture; //TODO : Add other fields here
                        scope.updateProfilePicture();
                    }
                    else{
                        ////(result);
                        scope.uploading  = false;
                        scope.$apply();
                        Toast.pullDown("Failed to Upload Picture<br/><p class='font-size-15'>"+result.errorMessage+"</p>", false, 16000);

                    }

                });

        }
    }
    function IdentityService($http)
    {
        var identityModel = {
          id : null,
        userId : null,
        password : null,
        type : null,
        gender : null,
        isActive : true,
        isBlocked : false,
        displayName : null,
        objType : null,
        pictureUrl : null,
        createdBy : null,
        phoneNumber : null,
        channelId : null,
    };
        var identityStoreCriteria = {
         updateProfilePicture :false,
         updateBlockedStatus :false,
         updatePassword :false,
         updateDisplayName :false,
         objectType :null,
         channelId :null,
         gender :null,
         activeState :false,
         blockedStatus :false,
         getByObjectType :false,
         getByIsActive :false,
         getByIsBlocked :false,
         getByChannel :false,
         getByGender :false,
         queryString : null,
         // loadOnlyAdmin  :false,
         getByDateCreatedRange :false,
            id  : null,
          pageSize : 50

        };
        var url  =effectiv.urls.identityUrl, urlAsync  =effectiv.urls.identityUrl2;
        return {
          getStates    : function()
          {
            return $http.get(effectiv.urls.appUrl , { params : { key  : 1,module : 'util'}});
          },
          getCountries    : function()
          {
            return $http.get(effectiv.urls.appUrl , { params : { key  : 2,module : 'util'}});
          },
          getLgaByState    : function(state)
          {
            return $http.get(effectiv.urls.appUrl , { params : { key  : 3, data  : state,module : 'util'}});
          },

            authorizeUser : function(userInfo)
            {
                return $http.post(effectiv.urls.authenticate,{userId : userInfo.userId,
                password : userInfo.password,
                isXhr : true,
                remember : userInfo.remember
                });
            },
            updatePreference  : function(preference)
            {

                return $http.get(url,{params : { key : 8,data : angular.toJson(preference) }});
            },
            getUsers  : function(criteria)
            {
                return $http.get(url,{params : {module:'identity', key : 7,criteria : angular.toJson(criteria) }});
            },
            getUser  : function(id,includePassword)
            {
                return $http.get(url,{params : {module:'identity', key : 6,data : id,trueFalse : includePassword }});
            } ,

          // Get a user Password
            getUserPassword  : function(userId,yourPassword)
            {
              return $http.post(url,{module:'identity', key : 60,data : userId,criteria : yourPassword });
            }
            ,updateUserPassword  : function(userId,oldPassword, newPassword)
            {
              return $http.post(url,{module:'identity', key : 702,data : userId,criteria : oldPassword, extraData : newPassword });
            },
            deleteUserAccount  : function(userId,yourPassword)
            {
              return $http.post(url,{module:'identity', key : 703,data : userId,criteria : yourPassword });
            },
            blockUserAccount  : function(userId,yourPassword)
            {
              return $http.post(url,{module:'identity', key : 700,data : userId,criteria : yourPassword });
            },
            unBlockUserAccount  : function(userId,yourPassword)
            {
              return $http.post(url,{module:'identity', key : 701,data : userId,criteria : yourPassword });
            },
            createUserAccount  : function (userInfo, roles, yourPassword) {
              userInfo =  angular.toJson(userInfo);
              roles  = angular.toJson(roles);
              return $http.post(url , { key : 200, data  : userInfo , criteria:roles  , extradata : yourPassword});
            }


            , registerNewUser  : function (userInfo) {
            userInfo =  angular.toJson(userInfo);
            return $http.post(urlAsync , { key : 10000, data  : userInfo });
          }




            ,getCurrentUser  : function(includePassword)
            {
                return $http.get(url,{params : {module:'identity', key : 5,trueFalse : includePassword }});
            },
            isUserAuthenticated  : function(){
                return $http.get(url,{params : {module:'identity', key : 4 }});
            },
            getModel  : identityModel,
            getCriteriaModel  : identityStoreCriteria,
          updateFields: function (data, criteria) {
            criteria = angular.toJson(criteria);
            data = angular.toJson(data);
            return $http.post(url, { module: 'identity', key: 1, data: data, criteria: criteria });
          },
          createSysAdminAcc  :function(data)
          {
            data = angular.toJson(data);
            return $http.post(url,{key : 10 ,data : data});
          },
          patchDb : function()
          {
             return $http.post(url,{key : 900 });
          },
          installApplicationRoles  : function () {
            return $http.post(url, {key : 3000});

          },
          // Get Date Ranges
          getDateRanges  :  function () {
            return $http.get(url, { params : { key  : 2000}});
          },
          forgotPasswordProcess  : function (userId, email) {
            return $http.post(url, { key: 501, data: userId, criteria: email });
          }
        };
    }

})(angular,window);
