class FavoritesController < ApplicationController

  def index
    @favorites = Favorites.new(favorites_args).all || [NullObject.new]
  end

  def create
    favorites = Favorites.new(favorites_args) || [NullObject.new]
    binding.pry
    args = { product_id: params[:product_id],
                    url: request.referrer,
                    id: favorites.next_id,
                    tearsheet: params[:tearsheet] }
    favorite = Favorite.new(args) || NullObject.new
    favorites.save(favorite) if !favorite.nil?

    cookies[:favorites] = favorites.all.to_json
     
    redirect_to :back 
  end
 
  private

  def favorites_args
    if cookies[:favorites] && cookies[:favorites].length > 2
      args = {}
      args[:favorites] = JSON.parse(cookies[:favorites])
      args
    else
      NullObject.new
    end
  end


end

