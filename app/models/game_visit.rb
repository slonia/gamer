class GameVisit < ActiveRecord::Base
  self.table_name = :users_games

  enum status: [:visited, :not_visited, :unknown]

  belongs_to :user
  belongs_to :game
end
