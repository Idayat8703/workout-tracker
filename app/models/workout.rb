class Workout < ActiveRecord::Base
  belongs_to :user
  validates :type_of_workout, :description, presence: true
end