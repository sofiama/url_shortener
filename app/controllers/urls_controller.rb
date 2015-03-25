class UrlsController < ApplicationController

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save && @url.valid?
      @url.update_short
      redirect_to @url
    else
      render :'new'
    end
  end

  def show
    begin
      @url = Url.find(params[:id]) 
    rescue ActiveRecord::RecordNotFound => e
      @url = Url.find_by(:short => params[:id])
      redirect_to @url.original
    end
  end

  def update
    @url = Url.find(params[:id])
    @url.counter += 1
    @url.save
    redirect_to @url.original
  end

  def index
    @urls = Url.all.order(:counter => :desc).first(100)
  end

  private
    def url_params
      params.require(:url).permit(:original)
    end
end
