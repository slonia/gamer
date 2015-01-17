class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates :user, presence: true

  def self.find_for_oauth(auth, user = nil)
    identity = find_or_create_by(uid: auth.uid, provider: auth.provider)
    name = (auth.provider.to_s == 'twitter') ? auth.info['nickname'] : auth.info['name']
    identity.update_attributes(name: name, image_url: auth.info['image'])
    identity
  end
end
