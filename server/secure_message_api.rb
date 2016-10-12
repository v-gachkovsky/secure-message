
class SecureMessageApi < Sinatra::Base
  client_path = File.expand_path('../client', File.dirname(__FILE__))

  set :views, File.join(client_path, 'views')
  set :public_folder, client_path

  get '/:page' do
    slim params[:page].to_sym
  end

  get '*' do
    slim :index
  end

end