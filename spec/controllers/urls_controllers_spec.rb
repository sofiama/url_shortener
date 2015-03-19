require "rails_helper"

RSpec.describe UrlsController do
  let(:valid_attributes){
    {:original => "https://github.com/sofiama"}
  }

  let(:invalid_attributes){
    {:original => nil}
  }

  describe "GET #new" do 
    before(:each) do
      get :new
    end
    it "reponds with a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "renders the new template" do
      expect(response).to render_template("new")
    end
    it "creates a new url" do 
      expect(assigns(:url)).to be_a_new(Url)
    end
  end

  describe "GET #index" do
    it "reponds with a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
    it "assigns @urls" do
      url = Url.create! valid_attributes
      get :index
      expect(assigns(:urls)).to eq([url])
    end  
  end

  describe "POST #create" do
    context "with valid params" do 
      it "creates a new Url" do
        expect{
          post :create, {:url => valid_attributes}
        }.to change(Url, :count).by(1)
      end
      it "assigns a newly created url as @url" do
        post :create, {:url => valid_attributes}
        expect(assigns(:url)).to be_a(Url)
        expect(assigns(:url)).to be_persisted
      end
      it "redirects it to #show" do
        post :create, {:url => valid_attributes}
        expect(response).to redirect_to(Url.last)
      end
    end

    context "when invalid attributes" do
      it "does not save the url" do
        expect{
          post :create, {:url => invalid_attributes}
        }.to change(Url, :count).by(0)
      end
      it "re-renders #new" do
        post :create, {:url => valid_attributes}
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #show" do
    # context 'when the params is the :id' do
    #   url = Url.create(:original => "https://github.com/sofiama")
    #   # get :show, {:id => url.id}
    #   it "responds with a 200 status code" do
    #     expect(response).to be_ok
    #   end
    #   it "assigns it to @url" do
    #     expect(assigns(:url)).to eq(url)
    #   end
    # end

    # context "when params is not the :id" do
    #   it 'throws ActiveRecord::RecordNotFound' do
    #     expect { get :show, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
    #   end
    # end
  end
end