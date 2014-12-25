class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :check_password, on: :create

  has_many :game_visits
  has_many :games, through: :game_visits
  belongs_to :team


  enumerize :role, in: [:player, :admin], default: :player, predicates: true

  private

    def check_password
      self.password = Devise.friendly_token.first(8) unless self.password
    end
end
