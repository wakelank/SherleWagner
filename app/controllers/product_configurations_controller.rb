class ProductConfigurationsController < ApplicationController
  def show
    product = Product.find_by(id: params[:product_id])
    configuration = product.product_configurations.find_by(finish: params[:finish])

    data = {configuration: configuration}.to_json

    render json: data
  end
end
