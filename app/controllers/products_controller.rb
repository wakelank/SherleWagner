class ProductsController < ApplicationController
  def upload_product_file
    Product.upload_product_file(params[:filename])

    redirect_to :back
  end

  def show
    @product = Product.find(params[:id])
    @material_types = @product.material_types
    @insert_types = @product.insert_types
    @associated_products = []
    @associated_products = @product.product_group.products
    respond_to do |format|
      format.html
      format.json { render json: @product.to_json(:methods => [:filters]) }
    end
  end

  def index
    @products = Product.all 
    @products = Product.all
    @categories = ProductSubType.all
    @filters = FilterProductValue.unique_filters

    respond_to do |format|
      format.html
      format.json { render json: { products: @products.to_json(:methods => [:filters]), 
                                   filters: @filters }
                   }
    end
  end

   def j_index
    @products = Product.all 
    @products = Product.all
    @categories = ProductSubType.all
    @filters = FilterProductValue.unique_filters

    respond_to do |format|
      format.html
      format.json { render json: { products: @products.to_json(:methods => [:filters]), 
                                   filters: @filters }
                   }
    end

  end

end
