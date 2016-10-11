require 'rubygems'
require 'bundler'

require 'sinatra'
require 'sinatra/mongo'

Bundler.require(:default)                   # load all the default gems
# Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require 'slim'