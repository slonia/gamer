class Game < ActiveRecord::Base
  has_many :game_visits
  has_many :users, through: :game_visits

  scope :active, -> { where('date >= ?', DateTime.now.beginning_of_day).order(:date) }
  def visited_by(user)
    self.game_visits.where(user_id: user).last
  end
end
