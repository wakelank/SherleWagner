class StylesController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
    
    @pics = Dir.glob("#{Rails.root}/public/images/col_img/*.png")
     
  end
  def show
    @style = Style.find(params[:id])
  end
end
