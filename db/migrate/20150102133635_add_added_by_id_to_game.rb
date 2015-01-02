class AddAddedByIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :added_by_id, :integer
    add_index :games, :added_by_id
  end
end
