class GameVisit < ActiveRecord::Base
  self.table_name = :users_games

  enum status: [:unknown, :visited, :not_visited]

  belongs_to :user
  belongs_to :game
end
