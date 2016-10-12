/**
 * Created by zett on 10/12/16.
 */
angular
  .module('secureMessageApp')
  .config([
    '$stateProvider',
    function($stateProvider) {
      $stateProvider
      .state('main', {
        url: '/',
        templateUrl: 'main'
      })
      .state('message', {
        url: '/message',
        templateUrl: 'message'
      });
}]);