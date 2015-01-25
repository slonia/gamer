class Game < ActiveRecord::Base
  paginates_per 10
  default_scope -> { order(:date) }

  has_many :game_visits
  has_many :users, through: :game_visits
  belongs_to :added_by, class_name: 'User', foreign_key: :added_by_id

  scope :active, -> { where('date >= ?', DateTime.now.beginning_of_day) }
  scope :for_next_week, -> { where('date >= ? AND date <= ?', (DateTime.now + 1.week).monday.beginning_of_day, (DateTime.now + 1.week).sunday.end_of_day) }
  scope :finished_in_season, -> { where('date >= ? AND date < ?', Game.season_start, Date.today)}

  def visited_by(user)
    self.game_visits.where(user_id: user).last
  end

  def start_date
    self.date.strftime("%d.%m")
  end

  def start_time
    self.date.strftime("%H:%M")
  end

  def self.season_start
    september = Date.today.change(month: 9, day: 1)
    if Date.today < september
      september - 1.year
    else
      september
    end
  end
end
