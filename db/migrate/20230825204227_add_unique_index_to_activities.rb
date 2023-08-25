class AddUniqueIndexToActivities < ActiveRecord::Migration[6.0]
  def change
    add_index :activities, "LOWER(name)", unique: true

  end
end
