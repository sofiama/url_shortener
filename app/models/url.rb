require 'uri'
class Url < ActiveRecord::Base
  validates_presence_of :original
  validates_uniqueness_of :short, :allow_blank => true

  validate :invalid_url

  def create_short
    str = Base64.urlsafe_encode64(self.id.to_s)

    self.update(
      :short => str
      )
  end

  def show_link
    host_name = "http://localhost:3000/"
    path = "urls/" + self.short
    link = host_name + path
  end

  private
    def invalid_url
      if self.original != /\A#{URI::regexp(['http', 'https'])}\z/
        errors.add(:original, 'must be a valid url')
      end
    end

end
