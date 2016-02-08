require 'find'
class DataRow


  attr_reader :component_number

  def initialize(row)
    @row = row

    @component_number = @row["CODE under Product Name"] || ""
    @generic_name = @row["GENERIC PRODUCT NAME _ Revised"] || ""
    @generic_number = @row["Generic Product Number"] || "" 
    @specific_number = @row["IMAGE FILE"] || ""
    @specific_name = @row["NAME"] || ""

    @image_name = get_image_name
    @product_type = get_product_type
    @product_sub_type = get_product_sub_type
    @style = get_style
    @genres = get_genres
    
  end

 
  def normal_product?
    !@image_name.blank? &&
      !compilation? &&
      !configuration?
  end

  def compilation?
    @component_number[0..4] == "TITLE"
  end


  def component?
    @image_name.blank? && !@component_number.blank?
    
  end

  def configuration?
    Product.exists?(number: @generic_number) && 
      @generic_name != "TITLE-XX" &&
      !@image_name.blank?
  end

  def product_number
    num = @generic_number
    
    if compilation?
      num = compilation_number
    end
    return num
  end

  
  def product_args
    args = { name: @generic_name,
      number: product_number,
      product_type: @product_type,
      product_sub_type: @product_sub_type,

    }
    if compilation?
      args[:name] = @specific_name
    end
    args
  end

  def configuration_args
    args = {
      number: @specific_number,
      description: @specific_name
    }
  end

  def product
    Product.find_by(number: product_number) ||
      Product.find_similar(product_number)
  end


  def component
    ebps_id = ProductSubType.find_by(name: "Elongated Back Plate Systems").id
    Product.
      where.not(product_sub_type: ebps_id). 
      where('number like ?' , "#{@component_number}%").first
  end

  def configuration
    ProductConfiguration.find_by(number: @specific_number)
  end

  def get_generic_name
    @row["GENERIC PRODUCT NAME _ Revised"] || ""
  end

  def get_generic_number
      @row["Generic Product Number"] || ""
  end

  def get_image_name
    name = @row["IMAGE FILE"] || ""
    name = name + ".jpg" if !name.blank?
    name
  end

  def get_specific_number
    @row["IMAGE FILE"] || ""
  end

  def get_product_type
    ProductType.get_arg @row
  end

  def get_product_sub_type
    ProductSubType.get_arg @row
  end

  def get_filters
    
    FilterValue.get_filter_values filter_args
  end

  def filter_args
    
    filter_values = []
    filter_values << (@row["FILTERS"] || "").downcase
    filter_values << (@row["FILTERS2"] || "").downcase
    
    {sub_type: @product_sub_type, values: filter_values}
  end

#  def get_product_configuration
#    ProductConfiguration.get_arg @row
#  end

  def get_style
    Style.get_arg @row
  end

  def get_genres
    Genre.get_arg @row
  end

  def get_component_number
    @row["CODE under Product Name"] || ""
  end

  def get_specific_name
    @row["NAME"] || ""
  end

  def compilation_number
   # if !component?
   if @specific_number.length > 8 && @generic_number.length > 6
      binding.pry if @specific_number[0..7].nil? || @generic_number[5..-1].nil?
      @specific_number[0..7]+@generic_number[5..-1]
    else
      ""
    end
  end
end

