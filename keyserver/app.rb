# app.rb
require 'sinatra'
require 'json'
require './key_manager.rb'


class KeyServerEndPoints < Sinatra::Base
  key_manager = KeyManager.new
  Thread.new do
      while true do
	  sleep 1
	  key_manager.cron_job
      end
  end
  get '/' do
    "Hello, world!"
  end

  get '/keys' do
      keys = key_manager.get_all
      keys.to_json
  end
  get '/init' do
      keys = key_manager.generate_keys
      keys.to_json
  end
  get '/new' do
      key = key_manager.get_key
      p key.class
      if key == nil
	  status 404
	  body '404'
      else
	  key.to_json
      end
  end
  get '/delete/:key' do
      key_manager.delete_key(params[:key])
  end
  get '/release/:key' do
      key_manager.release_key(params[:key])
  end
  get '/keepalive/:key' do
      key_manager.keep_alive(params[:key])
  end
end