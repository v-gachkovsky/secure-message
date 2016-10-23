
class Message
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  store_in collection: 'messages', database: 'secure-message-dev', client: 'default'

  field :_id
  field :data
  field :date
  field :visits
  field :destroy

end