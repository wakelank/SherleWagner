class ProductTypesController < ApplicationController

  def index
    @product_types = ProductType.all
  end
  
  def show
    @product_type = ProductType.find(params[:id])
  end

end
