
class Message
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  store_in collection: 'messages', database: 'secure-message-dev', client: 'default'

  # {
  #   "_id":"5802bf19881bf686fd5fa4f9",
  #   "data": {
  #     "iv":"gJSm80ps0oTLFUAxK2QSmQ==",
  #     "v":1,
  #     "iter":10000,
  #     "ks":128,
  #     "ts":64,
  #     "mode":"ccm",
  #     "adata":"",
  #     "cipher":"aes",
  #     "salt":"OieHDGZqd50=",
  #     "ct":"xJG5King1hIxrIKE2r8="
  #   },
  #   "date":1476577558571,
  #   "destroy": {
  #     "byTime":true,
  #     "byVisit":true,
  #     "afterTime":"1",
  #     "afterVisit":"1"
  #   }
  # }

  field :_id
  field :data
  field :date
  field :destroy

end