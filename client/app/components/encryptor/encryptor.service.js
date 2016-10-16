/**
 * Created by zett on 10/15/16.
 */
angular
  .module('secureMessageApp')
  .factory('EncryptorService', [
    function () {
      return {
        encrypt: function(data, password) {
          return sjcl.encrypt(password, data);
        },

        decrypt: function(password, encryptedData) {
          return sjcl.decrypt(password, encryptedData);
        }
      }
    }
  ]);