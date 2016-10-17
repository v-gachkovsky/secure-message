/**
 * Created by zett on 10/16/16.
 */
angular
  .module('secureMessageApp')
  .controller('OpenMessageCtrl', [
    '$scope', '$resource',
    'MessageHandlerService', 'MessageIDService', 'EncryptorService',
    function ($scope, $resource, MessageHandlerService, MessageIDService, EncryptorService) {
      $scope.attempts = 3;
      $scope.message = 'Message Encrypted. Enter password to decrypt message!';
      $scope.encryptedMessage = '';
      $scope.password = '';
      $scope.messageID = MessageIDService.getID();
      $scope.blocked = false;

      MessageHandlerService.get({ id: $scope.messageID }).$promise.then(function (data) {
        $scope.encryptedMessage = JSON.stringify(data);
        $scope.blocked = false;

        if (Object.keys($scope.encryptedMessage).length === 2) {
          $scope.message = 'Message had expired and was deleted';
          $scope.blocked = true;
        }
      });

      $scope.tryDecrypt = function() {
        $scope.attempts -= 1;
        if ($scope.attempts < 0) {
          $scope.attempts = 0;
          $scope.message = 'Sorry. You spent all your attempts. Message will be destroy.';
          return;
        }
        $scope.message = EncryptorService.decrypt($scope.password, $scope.encryptedMessage);
      }
    }
  ]);