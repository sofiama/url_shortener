class Url < ActiveRecord::Base
  validates_presence_of :original
  validates_uniqueness_of :short, :allow_blank => true

  def create_short
    str = Base64.urlsafe_encode64(self.id.to_s)

    self.update(
      :short => str
      )
  end

  def show_link
    protocol = self.original.split('/')[0]
    domain = self.original.split('/')[2]
    host_name = protocol + '//' + domain + '/'
    link = host_name + self.short.parameterize
  end
end
