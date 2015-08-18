class ProductsController < ApplicationController
  def upload_product_file
    Product.upload_product_file(params[:filename])

    redirect_to :back
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

end
