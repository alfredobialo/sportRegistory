/**
 * Created by USER on 3/15/2016.
 */

/// <reference path="typings/angularjs/legacy/angular-1.4.d.ts" />

module effectiv.Inventory
{
    var app   = angular.module("inventoryItem" , []);
    app.controller("ItemController" , ["$scope", InventoryItem]);
    export class InventoryItem
    {

        constructor(private scope : ng.IScope)
        {

        }
        showDetails(msg : string)
        {

        }
    }

}




