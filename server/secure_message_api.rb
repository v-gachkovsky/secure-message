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

  post '/create/message' do
    encrypted_data = JSON.parse request.body.read

    Message.new(
      _id: encrypted_data['_id'],
      data: encrypted_data['data'],
      date: encrypted_data['date'],
      destroy: encrypted_data['destroy']
    ).save
  end

  get '/message/:id' do

  end

  get '*' do
    slim :'views/index'
  end

end

SecureMessageApi.run!