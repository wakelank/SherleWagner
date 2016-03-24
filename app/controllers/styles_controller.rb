class StylesController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
    
    @pics = Dir.glob("#{Rails.root}/public/images/col_img/*.png")

  end
  def show
    @style = Style.find(params[:id])
    @genre = @style.genre

    @envi = []
    @style.environment_shots.each{|e|
      @envi.push(e.image.url)
    }
    
    

    
  end
end
