class TearsheetsController < ApplicationController

  def show
    @tearsheet_number = params[:tearsheet]
    @product = Product.find(params[:id]) || NullObject.new
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

