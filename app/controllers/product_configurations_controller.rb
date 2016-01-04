class ProductConfigurationsController < ApplicationController
  def show
    product = Product.find_by(id: params[:product_id])
#    configuration = product.
#      product_configurations.
#      where("number LIKE ?", "%#{params[:finish]}%").
#      where("number LIKE ?", "%#{params[:material]}%")


    configurations = product.
      product_configurations.
      where("number LIKE ?", "%#{params[:finish]}%")

    configurations = product.product_configurations.all unless configurations.length > 0

    configurations = configurations.select{ |configuration| configuration.number.include?(params[:material]) }
#todo this may not work if a material is not available
    data = {configuration: configurations}.to_json

    render json: data
  end
end
