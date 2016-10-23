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
    create_message JSON.parse request.body.read
  end

  get '/message/:id' do
    get_message params[:id]
  end

  delete '/message/:id' do
    delete_message params[:id]
    200
  end

  get '*' do
    slim :'views/index'
  end


  private
    # API handlers
    def get_message id
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

    def create_message encrypted_data
      Message.new(
        _id: encrypted_data['_id'],
        data: encrypted_data['data'],
        date: Time.now.to_i,
        visits: 0,
        destroy: encrypted_data['destroy']
      ).save
    end

    def delete_message id
      Message.where(_id: id).delete
    end

    # Helpers
    def expired? message_data
      destroy_way = message_data[:destroy]

      expired_by_time = false
      expired_by_visit = false

      if destroy_way['byTime']
        expired_by_time = expired_by_time? message_data.date, destroy_way['afterTime']
      end

      if destroy_way['byVisit']
        expired_by_visit = expired_by_visit? message_data.visits, destroy_way['afterVisit']
      end

      expired_by_time || expired_by_visit
    end

    def inc_visit id
      Message.collection.update_one({ _id: id }, { '$inc': { visits: 1 }})
    end

    def get_allowed_time count_of_hours
      3600 * count_of_hours.to_i
    end

    def expired_by_time? time_of_creation, count_of_hours
      count_of_allowed_seconds = get_allowed_time count_of_hours
      allowed_time = time_of_creation.to_i + count_of_allowed_seconds.to_i

      Time.now.to_i > allowed_time
    end

    def expired_by_visit? current_count_of_visits, allowed_count_of_visits
      allowed_count_of_visits.to_i < current_count_of_visits.to_i
    end

end