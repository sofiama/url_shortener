class Url < ActiveRecord::Base
  validates_presence_of :original
  validates :short, :uniqueness => true

  def create_short
    str = Base64.urlsafe_encode64(self.id.to_s)
    str = str.parameterize

    self.update(
      :short => str
      )
  end

  def show_link
    "#{self.short}"
  end
end
