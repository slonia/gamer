class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable

  before_validation :check_password, on: :create
  after_create :send_email

  has_many :game_visits
  has_many :games, through: :game_visits
  has_many :identities
  belongs_to :team


  enumerize :role, in: [:player, :captain, :admin], default: :player, predicates: true

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

    def send_email
      AppMailer.user_created(self).deliver_now!
    end
end
