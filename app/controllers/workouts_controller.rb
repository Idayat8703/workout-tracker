class WorkoutsController < ApplicationController

  get '/workouts' do
    if logged_in?
      @workouts = current_user.workouts
      erb :'/workouts/workouts'
    else
      flash[:message] = "** You must be logged in to view workouts. **"
      redirect to "/login"
    end
  end

  post '/workouts' do
      workout = current_user.workouts.build(name: params[:name], description: params[:description])
      if workout.save
        flash[:message] = "You successfully created a Workout plan!"
        redirect '/workouts'
      else
        flash[:message] = "You need to name your Workout!"
        redirect '/new'
      end
  end

  get '/new' do
    if !logged_in?
      flash[:message] = "** You must be logged in to create workouts. **"
      redirect to '/login'
    else
      erb :'/workouts/new'
    end
  end

  get '/workouts/:id' do
    @workout = Workout.find_by_id(params[:id])
    if logged_in?
      erb :'/workouts/show'
    else
      flash[:message] = "** You must be logged in to view workouts. **"
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do
    @workout = Workout.find_by_id(params[:id])
    if logged_in?
      erb :'/workouts/edit'
      else
      flash[:message] = "** You must be logged in to edit instruments. **"
      redirect to '/login'
    end
  end

  patch '/workouts/:id' do
    workout = Workout.find_by_id(params[:id])
    if params[:description] && params[:name]!= ""
      workout.description = params[:description]
      workout.name = params[:name]
      workout.save
      flash[:message] = "You successfully edited an instrument!"
      redirect '/workouts'
    else
      redirect "/workouts/#{workout.id}/edit"
    end
  end

  delete '/workouts/:id/delete' do
    @workout = Workout.find_by_id(params[:id])
    if @workout.user_id == current_user.id && @workout.delete
      flash[:message] = "You successfully deleted an instrument."
      redirect '/workouts'
    else
      redirect "/workouts/#{@workout.id}"
    end
  end

  end
