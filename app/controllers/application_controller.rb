require './config/environment'
require 'securerandom'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret,  "password" #SecureRandom.hex(64) #can't use hex while using shotgun
  end

  get '/' do
    "Hello, World!"
  end

end
