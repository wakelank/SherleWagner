class ProductGroupsController < ApplicationController
  def index
    @product_groups = ProductGroup.where(product_type_id: 13)
    @filters = unique_filter_hashes @product_groups

    respond_to do |format|
      format.html
      format.json { render json: { products_groups: @product_groups.as_json(:methods => [:get_filter_values]),
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

#  def get_filters product_groups
#    filters = []
#    product_groups.each do |product_group|
#     filter_names.concat product_group.filter_names 
#    end
#    filter_names.uniq
#  end

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
       

#  def filter_hashes product_groups
#    f_hashes = []
#    filter_names = []
#    product_groups.each do |product_group|
#      filter_name = product_group.filter_names
#      f_hashes << product_group.filter_hashes
#    end
#    
#    f_hashes.uniq
#  end


end
