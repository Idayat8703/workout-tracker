require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "gymrat"
    use Rack::Flash
  end

  get '/' do

    if logged_in?
      redirect '/workouts'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
      # binding.pry
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
