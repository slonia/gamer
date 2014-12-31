class Team < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users

  before_validation :set_slug

  validates :slug, presence: true, uniqueness: true

  def team_json(page = nil)
    page = page ? page.to_i : 1
    games = Game.active.page(page)
    users = self.users.includes(:game_visits)
    result = []
    games.each do |game|
      record = {
        name: game.name,
        date: game.date.strftime('%d.%m'),
        time: game.date.strftime('%H:%M'),
        id: game.id
      }
      users_array = []
      users.each do |user|
        users_array << {
          name: user.name,
          status: user.game_visits.find{ |g| g.game_id == game.id }.try(:status),
          id: user.id
        }
      end
      record[:users] = users_array
      result << record
    end
    result
  end

  private

    def set_slug
      self.slug = name.downcase.gsub(/\s/, '-')
    end
end
