class CreateWorkouts < ActiveRecord::Migration
  def change
   create_table :workouts do |t|
     t.string :type_of_workout
     t.string  :description
     t.integer :user_id
   end
  end
end
