class ProductGroupsController < ApplicationController
  def index

    @product_groups = ProductGroup.all
    @filters = unique_filter_hashes @product_groups

    respond_to do |format|
      format.html
      format.json { render json: { product_groups: @product_groups.as_json(:methods => [:get_filter_values]),
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
  

private
    def get_unique_filters product_groups
      filters = []
      product_groups.each do |product_group|
        filters << product_group.get_filters
      end
      filters = filters.flatten.uniq
    end

    def unique_filter_hashes product_groups
      f_hashes = []
      get_unique_filters(@product_groups).each do |filter|
        f_hashes << filter.filter_hash
      end
      f_hashes
    end
       
end
