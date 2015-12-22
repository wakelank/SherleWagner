class ProductConfigurationsController < ApplicationController
  def show
    compilation_name = "008BSN108-SLSL-XX"
    @product_configuration = ProductConfiguration.find_by(name: configuration_name)
    respond_to do |format|
      format.html
      format.json { render json: {name: name,
                                  finish: finish,
                                  material: material,
                                  china_color: china_color
                                  } 
                  }
    end
  end
end

