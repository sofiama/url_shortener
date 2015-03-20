require "rails_helper"

RSpec.describe Url, :type => :model do
  chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  omitted_chars = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U', 0, 1, 3]
  CHARS = (chars - omitted_chars)

  before :each do 
    @url = Url.create(
      :original => "https://github.com/sofiama",
      :counter => 0
    )
  end

  it "is valid with a url" do 
    expect(@url).to be_valid
  end

  it "starts with counter 0" do 
    expect(@url.counter).to eq(0)
  end

  it "has its own character set from a-z, A-Z, 0-9 that does not contain vowels and the numbers 0, 1, 3" do 
    expect(CHARS).not_to include("aeuiouAEIOU013")
  end

  describe "#encode" do
    it "encodes its id to the base value of the character set" do
      @url.update(:short => @url.encode)
      expect(@url.encode).to eq(@url.short) 
    end
  end

  describe "#decode" do 
    it "decodes its short url to its id" do
      @url.update(:short => @url.encode)
      expect(@url.decode).to eq(@url.id)
    end
  end

  describe "#update_short" do
    it "updates the short link with the encoded value" do
      @url.update(:short => @url.encode)
      expect(@url.short).to eq(@url.encode)
    end
  end

  describe "#show_link" do
    it "contains the host name and the short path" do 
      @url.update(:short => @url.encode)
      expect(@url.show_link).to eq("http://localhost:3000/urls/#{@url.short}")
    end
  end

  describe "#invalid_url" do
    it "validates that the url is of form http:// or https://" do
      expect(@url.original).to include("http")
      expect(@url.original).not_to be_empty
    end
  end
end