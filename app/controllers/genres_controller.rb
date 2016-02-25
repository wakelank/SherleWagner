class GenresController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
    @pics = Dir.glob("/public/images/col_img/*.png")
  end
  def show
    @genre = Genre.find(params[:id])
    @styles = @genre.styles
  end
end
