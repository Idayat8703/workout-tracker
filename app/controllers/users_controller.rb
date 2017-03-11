class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/workouts'
    else
      @user = User.new
      erb :'/users/signup'
    end
  end

# not sure if I need this or not
  get '/users/:slug' do
    if !logged_in?
     redirect '/'
   else
    @user = User.find_by_id(params[:slug])
    erb :'/users/show'
  end
end

  post '/signup' do
    redirect to '/' if logged_in?
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully created a user!"
      redirect to "/workouts"
    else
      flash[:message] = @user.errors.full_messages.join(", ")
      erb :'/users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/workouts'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/workouts"
    else
      flash[:message] = "Username and Password fields cannot be blank."
      erb :'/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have successfully logged out."
      redirect '/login'
    else
      redirect '/'
    end

  end

end
