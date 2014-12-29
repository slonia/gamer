class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates :user, presence: true

  def self.find_for_oauth(auth, user = nil)
    identity = find_or_initialize_by(uid: auth.uid, provider: auth.provider)
    identity.user = user if user
    return nil unless identity.user
    identity.save
    identity
  end
end
