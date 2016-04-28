class TearsheetsController < ApplicationController

  def show
    # @tearsheet_number = params[:tearsheet]
    # @product = Product.find(params[:id]) || NullObject.new
    
    # @config = @product.product_configurations.where(:number => @tearsheet_number)[0].image.url
    


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

  

  def create
    args = {}
    args[:material] = Material.find_by(id: params[:tearsheet][:material_id]) || NullObject.new
    args[:finish] = Finish.find_by(id: params[:tearsheet][:finish_id]) || NullObject.new
    args[:china_color] = ChinaColor.find_by(id: params[:tearsheet][:china_color_id]) || NullObject.new
    #todo product_id should be in the query string
    args[:product] = Product.find_by(id: params[:product_id]) || NullObject.new
    tearsheet = Tearsheet.new(args)

    redirect_to tearsheet_path ({ id: params[:product_id], tearsheet: tearsheet.number }) 
end

end

