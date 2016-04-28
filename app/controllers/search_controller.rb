class SearchController < ApplicationController

  def index
    #@query = Product.search do
    #      fulltext params[:search]
    #  end
    #  @searched = @query.results

    results = PgSearch.multisearch params[:search]
    @searched = results.map do |result|
      case result.searchable_type
      when "Product"
        product = Product.find_by_id(result.searchable_id)
        SearchResult.new(name: product.name,
                         image: product.image.url(:medium),
                         url: Rails.application.routes.url_helpers.product_path(product.id)
                        )
      when "ProductSubType"
        pst = ProductSubType.find_by_id(result.searchable_id)
        SearchResult.new(name: pst.name,
                         image: pst.image.url(:medium),
                         url: fetch_items_path(cat_id: pst.id)
                        )
      when "Style"
        style = Style.find_by_id(result.searchable_id)
        SearchResult.new(name: style.name,
                         image: "/images/medium/missing_product.jpg",
                         url: Rails.application.routes.url_helpers.style_path(style.id)
                        )
      end
    end
  end

# def j_search

#     @categories = ProductSubType.all
#     @filters = FilterProductValue.unique_filters

#     @query = Product.search do
#         fulltext params[:search]
#     end
#     @searched = @query.results

#      respond_to do |format|
#       # format.html
#       format.json { render json: { products: @searched.as_json(:methods => [:filters]), 
#                            filters: @filters, 
#                            query: @searched }
#                    }
#     end


#   end
end

#do a different ajax call to j_search path and return JSON of the returned @search_products and render a sidebar of filters from those 
