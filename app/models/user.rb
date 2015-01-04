class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable

  before_validation :check_password, on: :create
  after_create :after_create_actions

  has_many :game_visits
  has_many :games, through: :game_visits
  has_many :identities
  has_many :added_games, class_name: 'Game', foreign_key: :added_by_id
  has_many :team_requests
  belongs_to :team

  enumerize :role, in: [:player, :captain, :admin], default: :player, predicates: true

  attr_accessor :request_for_team_id, :new_team

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth, signed_in_resource)
    if identity
      user = signed_in_resource ? signed_in_resource : identity.user

      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end
  end

  def data_json
    identities = self.identities
    data = {
      name: name,
      team: team_info,
      identities: identities.pluck(:provider)
    }
  end

  def team_info
    return nil unless self.team
    {
      name: team.name,
      slug: team.slug
    }
  end

  private

    def check_password
      self.password = Devise.friendly_token.first(8) unless self.password
    end

    def after_create_actions
      if self.new_team.present?
        self.role = :captain
        team = Team.create(name: self.new_team)
        self.team_id = team
        self.save
      elsif self.request_for_team_id
        team = Team.find(self.request_for_team_id)
        TeamRequest.create(team: team, user: self)
      end
      # AppMailer.user_created(self).deliver_now!
    end
end
