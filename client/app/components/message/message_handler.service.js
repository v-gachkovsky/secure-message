/**
 * Created by zett on 10/15/16.
 */
angular
  .module('secureMessageApp')
  .factory('MessageHandlerService', [
    '$resource',
    function ($resource) {
      return $resource('/message/:id', {}, {
        save: {
          method: 'POST'
        },

        get: {
          method: 'GET'
        }
      });
    }
  ]);