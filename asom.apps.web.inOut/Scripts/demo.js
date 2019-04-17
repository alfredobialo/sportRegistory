/**
 * Created by USER on 3/15/2016.
 */
/// <reference path="typings/angularjs/legacy/angular-1.4.d.ts" />
var effectiv;
(function (effectiv) {
    var Inventory;
    (function (Inventory) {
        var app = angular.module("inventoryItem", []);
        app.controller("ItemController", ["$scope", InventoryItem]);
        var InventoryItem = (function () {
            function InventoryItem(scope) {
                this.scope = scope;
            }
            InventoryItem.prototype.showDetails = function (msg) {
            };
            return InventoryItem;
        }());
        Inventory.InventoryItem = InventoryItem;
    })(Inventory = effectiv.Inventory || (effectiv.Inventory = {}));
})(effectiv || (effectiv = {}));
//# sourceMappingURL=demo.js.map