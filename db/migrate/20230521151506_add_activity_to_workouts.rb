class AddActivityToWorkouts < ActiveRecord::Migration[6.0]
  def change
    add_column :workouts, :activity, :string
  end
end
