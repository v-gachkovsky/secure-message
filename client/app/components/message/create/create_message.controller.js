/**
 * Created by zett on 10/12/16.
 */
angular
  .module('secureMessageApp')
  .controller('CreateMessageCtrl', [
    '$scope', 'EncryptorService', 'MessageHandlerService',
    function ($scope, EncryptorService, MessageHandlerService) {
      function s(s) {
        return Math.floor(s).toString(16);
      }

      $scope.createId = function(s) {
        return s(Date.now() / 1000) + ' '.repeat(16).replace(/./g, function() {
          return s(Math.random() * 16)
        });
      };

      $scope.id = $scope.createId(s);
      $scope.password = '';
      $scope.message  = '';
      $scope.destroy = {
        byTime  : true,
        byVisit : true,
        afterTime  : '1',
        afterVisit : '1'
      };
      
      $scope.createMessage = function() {
        var id = $scope.id;
        var encryptedMessage = EncryptorService.encrypt($scope.password, $scope.message);

        var encryptedData = {
          _id: id,
          data: JSON.parse(encryptedMessage),
          destroy: {
            byTime: $scope.destroy.byTime,
            byVisit: $scope.destroy.byVisit,
            afterTime: $scope.destroy.afterTime,
            afterVisit: $scope.destroy.afterVisit
          }
        };

        MessageHandlerService.save(encryptedData);
      }
    }
  ]);
