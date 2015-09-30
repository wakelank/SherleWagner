class ProductGroupsController < ApplicationController
  def index
    @product_groups = ProductGroup.all.limit 100
    @filters = get_filters_for @product_groups

    respond_to do |format|
      format.html
      format.json { render json: { product_groups: @product_groups.as_json(:methods => [:filters]), 
                                   filters: @filters }
                   }

                   
    end
  end

  def show
    @product_group = ProductGroup.find(params[:id])
  end

  def get_filters_for product_groups
    filter_name_values = {}
    filter_name_values.default = []

    filter_values = []

    product_groups.each do |product_group|
      
      filter_values.concat product_group.filter_values
    end

    filter_values.uniq.each do |filt|
      fname = Filter.find(filt.filter_id).name
          filter_name_values[fname] = filter_name_values[fname].push(filt.name)
    end
    filter_name_values
  end
  

end
