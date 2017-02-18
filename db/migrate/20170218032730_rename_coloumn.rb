class RenameColoumn < ActiveRecord::Migration
  def change
    rename_column :workouts, :type_of_workout, :name
  end
end
