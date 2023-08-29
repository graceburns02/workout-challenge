class CreateInjuries < ActiveRecord::Migration[6.0]
  def change
    create_table :injuries do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
