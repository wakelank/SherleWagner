class ProductsController < ApplicationController
  def upload_products
    Product.load_file(params[:filename])

    redirect_to root
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

end
