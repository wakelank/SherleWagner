class ProductSubTypesController < ApplicationController
  def show
    @product_sub_type = ProductSubType.find(params[:id])
  end

end
