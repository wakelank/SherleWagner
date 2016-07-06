class ProductsController < ApplicationController
before_action :authenticate_user!, only: [:upload_product_file]

  def upload_product_file
    Product.new_upload_product_file(params[:filename])

    redirect_to :back
  end


  def show
    @product = Product.find(params[:id])
    @finishes = []
    @product.finishes.each do |f|
      ob = {}
      ob["name"] = f.name
      ob["identifier"] = f.identifier
      ob["swatch"] = f.modern_swatch_url
      if @product.ornate?
        ob["swatch"] = f.ornate_swatch_url
      end
    @finishes << ob
    end
    
    if @product.product_configurations.length >= 10
      @list_width = "image_list_wide"
    else
      @list_width = ""
    end

 

    recently_viewed_products = []
    if cookies[:recently_viewed_products] && cookies[:recently_viewed_products].length > 2
      recently_viewed_products = JSON.parse(cookies[:recently_viewed_products])
    end
    recently_viewed_products << { product_id: @product.id }
    while recently_viewed_products.length > 5
      recently_viewed_products.shift 1
    end
    cookies[:recently_viewed_products] = recently_viewed_products.to_json
                                            
  end

  



  def tearsheet
    product_number = params[:product_id]
    @product = Product.find(product_number)
    @tearsheet_number = params[:tearsheet_number]
    @tearsheet_number_s = @tearsheet_number.split('-')
    @tearsheet_number_s.pop
    @tearsheet_number_s = @tearsheet_number_s.join('-')
    
    if @product.components.length >= 1
      @configs = @product.product_configurations.where("number like ?", "%#{@tearsheet_number_s}%")
      
    else
      @configs = @product.product_configurations.where("number like ?", "%#{@tearsheet_number}%")
      
    end
    if @configs.length >= 1 
      @name = @configs[0].description
      if !@configs[0].image.url.include?('missing')

        @config_img = @configs[0].image.url 
      end
    else
      @name = @product.name
      @config_img = @product.image.url  
    end
   
    @finishes = []
    @product.finishes.each do |f|
      ob = {}
      ob["name"] = f.name
      ob["identifier"] = f.identifier
      ob["swatch"] = f.modern_swatch_url
        if @product.ornate?
          ob["swatch"] = f.ornate_swatch_url
        end
      @finishes << ob
    end 
    
  end

  def from_category
    @selected = Product.where(product_sub_type: params[:cat_id]).order(:page_section).order(:section_position).order(:created_at)
    @product_sub_type = ProductSubType.find_by(id: params[:cat_id])

    respond_to do |format|
      format.js
    end
  end

  def product_json
    # this will receive ajax req and send a product's data to product/show in order to correctly position the side nav
  end

 def edit
    @product = Product.find(params[:id])
    @materials = Material.all#@product.materials
   
  end

  def update
    @product = Product.find(params[:id])
    
    @product.update(product_params)
    @product.update(product_type: @product.product_sub_type.product_type)
    redirect_to product_path params[:id]
  end

    
  def destroy
    product = ProductGroup.find(params[:id])
    product.destroy
    redirect_to product_path
  end


private
  def product_params
    params.require(:product).permit(:name,
                                    :number,
                                    :product_sub_type_id,
                                    :finish_ids => [],
                                    :material_ids => [],
                                    :style_ids => [],
                                    :genre_ids => []
                                   )
  end


end
