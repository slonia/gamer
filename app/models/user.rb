class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable

  before_validation :check_password, on: :create

  has_many :game_visits
  has_many :games, through: :game_visits
  belongs_to :team


  enumerize :role, in: [:player, :admin], default: :player, predicates: true

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth, signed_in_resource)

    user = signed_in_resource ? signed_in_resource : identity.user

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  private

    def check_password
      self.password = Devise.friendly_token.first(8) unless self.password
    end
end
