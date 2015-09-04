class ProductsController < ApplicationController
  def upload_product_file
    Product.upload_product_file(params[:filename])

    redirect_to :back
  end

  def show
    @product = Product.find(params[:id])
    @material_types = @product.material_types
    @insert_types = @product.insert_types
    @associcated_products = []
    @associated_products = @product.product_group.products
  end

  def index
    @products = Product.all
  end

end
