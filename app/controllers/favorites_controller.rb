class FavoritesController < ApplicationController

  def index
    @products = []
    favorite_params = JSON.parse(cookies[:favorites])
    favorite_params.each do |favorite_param|
      product_id = favorite_param["product_id"]
      product = Product.find_by(id: product_id) || NullObject.new
      @products << product if !product.nil?
    end

  end

  def create
    favorites = []
    favorites = JSON.parse(cookies[:favorites]) if cookies[:favorites].length >=2
    favorites << { product_id: params[:product_id] }
    cookies[:favorites] = favorites.to_json
     
    redirect_to :back 
  end
  

end

