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
        templateUrl: '/partials/main'
      })
      .state('message', {
        url: '/message',
        templateUrl: 'partials/message'
      })
      .state('create_message', {
        url: '/create_message',
        templateUrl: 'partials/create_message'
      });
}]);