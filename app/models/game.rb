class Game < ActiveRecord::Base
  has_many :game_visits
  has_many :users, through: :game_visits

  def visited_by(user)
    self.game_visits.where(user_id: user).last
  end
end
