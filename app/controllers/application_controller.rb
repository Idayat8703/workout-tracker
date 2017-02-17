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
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      if !!current_user
        true
      else
        flash[:message] = "You are not logged in."
        redirect to "/login"
      end
    end
  end
end
