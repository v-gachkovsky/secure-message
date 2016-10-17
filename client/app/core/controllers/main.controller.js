/**
 * Created by zett on 10/16/16.
 */
angular
  .module('secureMessageApp')
  .controller('MainCtrl', [
    '$scope', 'MessageIDService',
    function ($scope, MessageIDService) {
      $scope.messageID = '';

      $scope.setMessageID = function(newID) {
        MessageIDService.setID(newID);
      }
    }
  ]);