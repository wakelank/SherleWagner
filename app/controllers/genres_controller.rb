class GenresController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
  end
  def show
    @genre = Genre.find(params[:id])
    @styles = @genre.styles
  end
end
