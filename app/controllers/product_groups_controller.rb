class ProductGroupsController < ApplicationController
  def index
    @product_groups = ProductGroup.all.limit 100
  end

  def show
    @product_group = ProductGroup.find(params[:id])
  end

end
