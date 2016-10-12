/**
 * Created by zett on 10/12/16.
 */

angular
  .module('secureMessageApp')
  .controller('SomeCtrl', [
    '$scope',
    function ($scope) {
      $scope.experiment = 'Hello, Angular';
    }
  ]);

