require "rails_helper"

RSpec.describe Url, :type => :model do
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

  describe '#create_short' do
    it 'uses base64 to encode its id to a urlsafe string' do
      expect(@url.create_short).to eq(@url.create)
    end
  end
end