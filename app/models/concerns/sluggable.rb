module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :set_slug
  end

  private

    def set_slug
      I18n.locale = :en
      slug = I18n.transliterate(name.mb_chars.underscore)
      slug = slug.trim.gsub(/[ _-]/, '-').split('').map {|s| (s.match(/\w/) || s.match('-')) }.join.gsub(/((-)\2*)/, '-')
      self.slug = slug
      I18n.locale = :ru
    end
end
