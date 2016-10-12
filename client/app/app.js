/**
 * Created by zett on 10/11/16.
 */
angular
  .module('secureMessageApp', [
    'ngResource', 'ui.router'
  ]).config(['$urlRouterProvider', '$locationProvider',
  function($urlRouterProvider, $locationProvider) {
    $urlRouterProvider.otherwise('/');

    $locationProvider.html5Mode({
      enabled: true,
      requireBase: false
    });
  }]);