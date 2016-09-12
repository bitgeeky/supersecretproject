# app.rb
require 'sinatra'
require 'json'
require './key_manager.rb'


class KeyServerEndPoints < Sinatra::Base
  key_manager = KeyManager.new
  get '/' do
    "Hello, world!"
  end

  get '/gen_keys' do
      keys = key_manager.generate_keys
      keys.to_json
  end
  get '/get_key' do
      key = key_manager.get_key
      key.to_json
  end
end