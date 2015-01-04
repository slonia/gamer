class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates :user, presence: true

  def self.find_for_oauth(auth, user = nil)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
