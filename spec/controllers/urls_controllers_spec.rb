require "rails_helper"

RSpec.describe UrlsController do
  let(:valid_attributes){
    {:original => "https://github.com/sofiama",
      :counter => 0}
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

  describe "POST #create" do
    context "with valid attributes" do 
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
    before (:each) do
      @url = Url.create! valid_attributes
      @url.update_short
    end

    context "when the params is the :id" do
      it "responds with a 200 status code" do
        get :show, {:id => @url.id}
        expect(response).to be_ok
      end
    end

    context "when params is the short" do
      it "redirects to the original link" do
        get :show, {:id => @url.short}
        expect(response).to redirect_to(@url.original)
      end
    end
  end

  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "reponds with a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end
end