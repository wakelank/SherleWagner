class ProductsController < ApplicationController
  def upload_products
    Product.load_file(params[:filename])

    redirect_to root
  end

  def show
  end

  def index
  end

end
