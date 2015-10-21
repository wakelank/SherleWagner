class ProductsController < ApplicationController
  def upload_product_file
    Product.new_upload_product_file(params[:filename])

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
      format.json { render json: { products: @products.as_json(:methods => [:filters]), 
                                   filters: @filters }
                   }
    end
  end

  def build_tearsheet
    product_base_number = params[:product_base_number]
    material_code = Material.find(params[:material_id]).identifier
    finish_code = Finish.find(params[:finish_id]).identifier

    product_number = product_base_number + '-' + material_code + '-' + finish_code;
    respond_to do |format|
      format.html
      format.json { render json: { product_number: product_number } }
    end
  end

  def show_tearsheet
    @product_number = params[:product_number]

  end


   

end
