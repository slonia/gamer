class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable

  before_validation :check_password, on: :create
  after_save :after_save_actions, unless: :created_from_identity

  has_many :game_visits
  has_many :games, through: :game_visits
  has_many :identities, dependent: :destroy
  has_many :added_games, class_name: 'Game', foreign_key: :added_by_id
  has_many :team_requests, dependent: :destroy
  belongs_to :team

  enumerize :role, in: [:player, :captain, :admin], default: :player, predicates: true

  attr_accessor :request_for_team_id, :new_team, :created_from_identity

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth, signed_in_resource)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = 'temp_' + auth.uid.to_s + '@' + auth.provider + '.com'
      user = User.find_or_initialize_by(email: email)
      user.name = auth.uid
      user.created_from_identity = true
      user.save!
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
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

  [:twitter, :facebook, :vkontakte].each do |social|
    define_method "has_#{social}?" do
      identities.find { |i| i.provider.to_sym == social}
    end
  end

  def weekly_toggle(provider)
    if provider == 'email'
      self.update_column(:weekly_reminder, !self.weekly_reminder)
    else
      if identity = self.send("has_#{provider}?")
        identity.update_column(:weekly_reminder, !identity.weekly_reminder)
      else
        false
      end
    end
  end

  private

    def check_password
      self.password = Devise.friendly_token.first(8) unless self.password
    end

    def after_save_actions
      if self.new_team.present?
        team = Team.create(name: self.new_team)
        self.update_columns(role: :captain, team_id: team.id)
      elsif self.request_for_team_id
        team = Team.find(self.request_for_team_id)
        TeamRequest.create(team: team, user: self)
      end
      # AppMailer.user_created(self).deliver_now!
    end
end
