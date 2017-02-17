class UsersController < ApplicationController
  get '/users' do
    if logged_in?
      flash[:message] = "You are already logged in."
     redirect to "/workouts"
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect to "/workouts"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Successfully logged in."
      redirect to "/workouts"
    else
      flash[:message] = "Please double-check your login information!"
      redirect to "/login"
    end
  end

  post '/users' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Sign up successful!"
      redirect to "/workouts"
    else
      flash[:message] = "Please complete the form!"
      redirect to "/users"
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user
        @users_workouts = @user.workouts
        erb :'users/show'
      else
        redirect to "/workouts"
      end
    else
      redirect to "/"
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "Successfully logged out."
    redirect to "/"
  end
end
