class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.boolean :private
      t.integer :workout_count
      t.integer :workouts_count

      t.timestamps
    end
  end
end
