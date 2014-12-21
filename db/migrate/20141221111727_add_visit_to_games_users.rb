class AddVisitToGamesUsers < ActiveRecord::Migration
  def change
    add_column :users_games, :status, :integer
  end
end
