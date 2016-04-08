class SearchController < ApplicationController

def index
  #@query = Product.search do
  #      fulltext params[:search]
  #  end
  #  @searched = @query.results

    results = PgSearch.multisearch params[:search]
    @searched = results.map { |result| Product.where(id: result.id) }.flatten
    

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
