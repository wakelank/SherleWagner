class StylesController < ApplicationController

  def index
    @styles = Style.all
    @genres = Genre.all
    
    @pics = Dir.glob("#{Rails.root}/public/images/col_img/*.png")
    # @contemporary = Genre.where(:name => "Contemporary").pluck(:id).first
    # @classic = Genre.where(:name => "Classic").pluck(:id).first
    # @ornate = Genre.where(:name => "Ornate").pluck(:id).first
    # @traditional = Genre.where(:name => "Traditional").pluck(:id).first
     
  end
  def show
    @style = Style.find(params[:id])
  end
end
