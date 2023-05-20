class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.integer :user_id
      t.string :name
      t.date :date
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
