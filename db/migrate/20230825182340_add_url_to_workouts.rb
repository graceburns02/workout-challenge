class AddUrlToWorkouts < ActiveRecord::Migration[6.0]
  def change
    add_column :workouts, :url, :string
  end
end
