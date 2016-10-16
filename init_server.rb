require 'rubygems'
require 'bundler'

require 'sinatra'
require 'json'
require 'mongoid'

require 'slim'

Bundler.require(:default) # load all the default gems
Sinatra::Base.environment
Mongoid.load!('server/config/mongoid.yml', :development)

require_relative './server/secure_message_api'

SecureMessageApi.run!