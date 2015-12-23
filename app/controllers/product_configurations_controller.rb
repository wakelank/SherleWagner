class ProductConfigurationsController < ApplicationController
  def show
    product = Product.find_by(id: params[:product_id])
    configuration = product.
      product_configurations.
      where("number LIKE ?", "%#{params[:finish]}%").
      where("number LIKE ?", "%#{params[:material]}%")

    data = {configuration: configuration}.to_json

    render json: data
  end
end
