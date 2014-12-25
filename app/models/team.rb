class Team < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users

  before_save :set_slug

  private

    def set_slug
      self.slug = name.downcase.gsub(/\s/, '-')
    end
end
