class WorkoutsController < ApplicationController

  get '/workouts' do
    @workouts = Workout.all
    erb :'workouts/index'
  end
  
  get '/workouts/:id' do
     @workout = Workout.find(params[:id])
     erb :'workouts/show'
   end
end
