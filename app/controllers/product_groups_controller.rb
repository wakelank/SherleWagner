class ProductGroupsController < ApplicationController
  def index
    @product_groups = ProductGroup.all.limit 100
    @filters = filter_hashes @product_groups

    respond_to do |format|
      format.html
      format.json { render json: { products_groups: @product_groups.as_json(:methods => [:filters]), 
                                   filters: @filters }
                   }
    end
  end

  def show
    @product_group = ProductGroup.find(params[:id])
  end

 # def get_filters_for product_groups
 #   filter_values = []
 #   filtersArr = []
 #   product_groups.each do |product_group|
 #     filter_values.concat product_group.filter_values
 #   end
 #   filter_values.uniq
 # end

  def get_filters_names_for product_groups
    filters = []
    product_groups.each do |product_group|
     filter_names.concat product_group.filter_names 
    end
    filter_names.uniq
  end

  def filter_hashes product_groups
    f_hashes = []
    filter_names = []
    product_groups.each do |product_group|
      filter_name = product_group.filter_names
      f_hashes << product_group.filter_hashes
    end
    
    f_hashes.uniq
  end


end
