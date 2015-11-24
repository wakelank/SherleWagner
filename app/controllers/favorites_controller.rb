class FavoritesController < ApplicationController

  def index
    @favorites = []
    favorite_params = JSON.parse(cookies[:favorites])
    favorite_params.each do |favorite_param|
      product_id = favorite_param["product_id"]
      product = Product.find_by(id: product_id) || NullObject.new
      url = favorite_param["url"] || ""
      @favorites << { product: product, url: url }
    end

  end

  def create
    favorites = []
    favorites = JSON.parse(cookies[:favorites]) if cookies[:favorites]
    favorites << { product_id: params[:product_id],
                    url: request.referrer }
    cookies[:favorites] = favorites.to_json
     
    redirect_to :back 
  end
 

end

