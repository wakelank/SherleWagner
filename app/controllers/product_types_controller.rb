class ProductTypesController < ApplicationController

  def index
    

    @product_types = ProductType.all
    if params["id"]
      @id = params["id"]
      @selected = Product.where(product_type: @id)
    @product_type = ProductType.find_by(id: @id)

    end
  end
  
  def show
    @product_type = ProductType.find(params[:id])
  end
  def an_category
    @selected = Product.where(product_type: params[:cat_id])
    @product_type = ProductType.find_by(id: params[:cat_id])

    respond_to do |format|
      format.js
    end
  end
  def fetched_category
    # @selected = Product.where(product_type: params[:cat_id])
    @product_type = ProductType.find_by(name: params[:name])

    respond_to do |format|
      format.js
    end
  end



end
