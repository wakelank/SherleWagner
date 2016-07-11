class FavoritesController < ApplicationController

  def index
    @favorites = Favorites.new(favorites_args).all || [NullObject.new]
  end

  def create
    favorites = Favorites.new(favorites_args) || [NullObject.new]
    args = { product_id: params[:product_id],
                    url: request.referrer,
                    id: favorites.next_id,
                    tearsheet: params[:tearsheet] }
    favorite = Favorite.new(args) || NullObject.new
    favorites.save(favorite) if !favorite.nil?

    cookies[:favorites] = favorites.all.to_json
    
    redirect_to :back 
  end

  def create_inquiry
    favorites = Favorites.new(favorites_args) || [NullObject.new]
    args = { product_id: params[:product_id],
                    url: request.referrer,
                    id: favorites.next_id,
                    tearsheet: params[:tearsheet] }
    favorite = Favorite.new(args) || NullObject.new
    favorites.save(favorite) if !favorite.nil?

    cookies[:favorites] = favorites.all.to_json
    
    redirect_to favorites_path
  end
 
  def destroy
    favorites = Favorites.new(favorites_args) || [NullObject.new]
    favorites.delete(params[:id])
    cookies[:favorites] = favorites.all.to_json

    redirect_to favorites_path
  end

  def send_contact_with_favorites
    begin
    ContactWithFavorites.email_favorites(favorites: params[:favorites],
                                         requesters_email: params[:requesters_email],
                                         requesters_location: params[:requesters_location],
                                         requesters_comment: params[:requesters_comment]).deliver_now

    flash[:success] = "Your message has been sent. A customer service representative will contact your shortly."
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e 
      flash.delete :success
      flash[:danger] = "We're sorry. There was a problem with sending your message. Please call 1-(212)768-3300."
    end
  redirect_to favorites_path
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

