/**
 * Created by zett on 10/15/16.
 */
angular
  .module('secureMessageApp')
  .factory('SenderService', [
    '$resource',
    function ($resource) {
      return $resource('/create/message', {}, {
        save: {
          method: 'POST'
        }
      });
    }
  ]);