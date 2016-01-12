class StylesController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
  end
  def show
    @style = Style.find(params[:id])
  end
end
