require 'uri'
class Url < ActiveRecord::Base
  validates_presence_of :original
  validates_uniqueness_of :short, :allow_blank => true

  validate :invalid_url

  chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  omitted_chars = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U', 0, 1]
  CHARS = (chars - omitted_chars).shuffle.join
  BASE = CHARS.length

  def encode
    num = self.id - 1
    return CHARS[0] if num == 0

    str = ""

    while num > 0
      str << CHARS[(num % BASE)]
      num /= BASE
    end
    str
  end

  def decode
    i = 0 

    self.short.each_char do |c|
      i = i * BASE + CHARS.index(c)
    end
    i
  end

  def update_short
    self.update(
      :short => self.encode
      )
  end

  def show_link
    host_name = "http://localhost:3000/"
    path = "urls/" + self.short
    link = host_name + path
  end

  private
    def invalid_url
      if !(self.original =~ /\A#{URI::regexp(['http', 'https'])}\z/)
        errors.add(:original, 'must be a valid url')
      end
    end

end
