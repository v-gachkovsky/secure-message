/**
 * Created by zett on 10/16/16.
 */
angular
  .module('secureMessageApp')
  .factory('MessageIDService', [
    function () {
      var messageID;

      return {
        getID: function() {
          return messageID;
        },

        setID: function(newID) {
          messageID = newID;
        }
      };
    }
  ]);