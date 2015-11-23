class Tearsheet 
  def materials_id
  end
  def finish_id
  end
  def china_color_id
  end

  def initialize(args)
    @material = args[:material]
    @finish = args[:finish]
    @china_color = args[:china_color]
    @product = args[:product]
  end

  def number
    #TODO refactor material_code_regex into helper
    material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE)/
    number = @product.number
    number.sub!("XX", @finish.identifier) if !@finish.nil?
    number.sub!("CC", @china_color.identifier) if !@china_color.nil?
    number.sub!(material_code_regex, @material.identifier) if !@material.nil?
    number
  end

    
    


  def build_tearsheet

#    product_base_number = ""
    material_code = ""
    finish_code = ""
    china_color_code = ""
    product_number_params = [] 
    product_group = ProductGroup.find(params[:product_group_id])

 #   product_base_number = params[:product_base_number] if !params[:product_base_number].blank?
    material_code = Material.find(params[:material_id]).identifier if !params[:material_id].blank?
    finish_code = Finish.find(params[:finish_id]).identifier if !params[:finish_id].blank?
    china_color_code = ChinaColor.find(params[:china_color_id]).identifier if !params[:china_color_id].blank?
    product_group_id = params[:product_group_id] if !params[:product_group_id].blank?
    finish_id = params[:finish_id] if !params[:finish_id].blank?
    material_id = params[:material_id] if !params[:material_id].blank?
    china_color_id = params[:china_color_id] if !params[:china_color_id].blank?

    material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE)/

    product_number_params << { replace_this: 'XX', with_this: finish_code }
    product_number_params << { replace_this: 'CC', with_this: china_color_code }
    product_number_params << { replace_this: material_code_regex, with_this: material_code }
    
    product_number = product_group.number

    product_number_params.each do |param|
      product_number.sub!(param[:replace_this], param[:with_this]) if !param[:with_this].blank?
    end

    # product_number = product_group.number.sub('XX', finish_code).sub('CC', china_color_code).sub(material_code_regex, material_code)
    respond_to do |format|
      format.html
      format.json { render json: { product_number: product_number,
                                   product_group_id: product_group_id,
                                   material_id: material_id,
                                   china_color_id: china_color_id,
                                   finish_id: finish_id } }
    end
  end

end


