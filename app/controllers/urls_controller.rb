class UrlsController < ApplicationController
  respond_to :html, :json

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      @url.create_short
      redirect_to @url
    else
      render :'new'
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  def update
    @url = Url.find(params[:id])
    @url.counter += 1
    @url.save
    redirect_to @url.original
  end

  def index
    @urls = Url.all
  end

  private
    def url_params
      params.require(:url).permit(:original)
    end
end
