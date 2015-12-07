class ProductSubTypesController < ApplicationController
  def show
    @product_sub_type = ProductSubType.find(params[:id])
    @items = [Product.second]

  end

end
