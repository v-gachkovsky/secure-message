require_relative './models/message'

class SecureMessageApi < Sinatra::Base
  client_path = File.expand_path('../client', File.dirname(__FILE__))

  configure do
    set :root, File.expand_path('../', File.dirname(__FILE__))
    set :views, client_path
    set :public_folder, client_path
    set :layout, false
  end

  get '/favicon.ico' do
    ''
  end

  get '/partials/:name' do
    slim :"views/partials/#{params[:name]}"
  end

  get '/client/app/components/message/:action/:template_name' do
    slim :"app/components/message/#{params[:action]}/#{params[:template_name].sub '.html', ''}"
  end

  post '/message' do
    encrypted_data = JSON.parse request.body.read

    Message.new(
      _id: encrypted_data['_id'],
      data: encrypted_data['data'],
      date: Time.now.to_i,
      visits: 0,
      destroy: encrypted_data['destroy']
    ).save
  end

  get '/message/:id' do
    id = params[:id]
    inc_visit id
  begin
    message_data = Message.find_by(_id: id)
  rescue
    return :deleted
  end
    message = message_data.data

    if expired? message_data
      delete_message id
      :deleted
    else
      JSON.generate message
    end
  end

  get '*' do
    slim :'views/index'
  end

  def expired? message_data
    destroy_way = message_data[:destroy]

    expired_by_time = false
    expired_by_visit = false

    if destroy_way['byTime']
      now = Time.now.to_i
      time_of_creation = message_data.date
      count_of_allowed_seconds = get_allowed_time destroy_way['afterTime']
      allowed_time = time_of_creation.to_i + count_of_allowed_seconds.to_i

      expired_by_time = now > allowed_time
    end

    if destroy_way['byVisit']
      current_count_of_visits = message_data.visits
      allowed_count_of_visits = destroy_way['afterVisit']
      expired_by_visit = allowed_count_of_visits.to_i < current_count_of_visits.to_i
    end

    expired_by_time || expired_by_visit
  end

  def delete_message id
    Message.where(_id: id).delete
  end

  def inc_visit id
    Message.collection.update_one({ _id: id }, { '$inc': { visits: 1 }})
  end

  def get_allowed_time count_of_hours
    3600 * count_of_hours.to_i
  end

end

# SecureMessageApi.run!