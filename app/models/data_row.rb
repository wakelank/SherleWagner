require 'find'
class DataRow

  #images_path = "/Users/ph1am/Desktop/SW website/images1"
  IMAGES_PATH = "/Users/wake/Documents/Work/SherleWagner/images"
  # images_path = image_file_path

  def initialize row
    @row = row
    @generic_name = get_generic_name
    @generic_number = get_generic_number
    @image_name = get_image_name
    @specific_number = get_specific_number
    @product_type = get_product_type
    @product_sub_type = get_product_sub_type
    @image = get_image
    @style = get_style
    @genres = get_genres
  end

 
  def normal_product?
    !@image_name.blank? && !compilation?
  end

  def compilation?
    @generic_number == "TITLE-XX"
  end

  def component?
  end

  def configuration?
  end

  def product_args
    { name: @generic_name,
      number: @generic_number,
      product_type: @product_type,
      product_sub_type: @product_sub_type,
      image: @image
    }
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
    FilterValue.get_arg @row
  end

  def get_product_configuration
    ProductConfiguration.get_arg @row
  end

  def get_image
    Find.find(IMAGES_PATH) do |filepath|
      if File.basename(filepath) == @image_name
        @image_file = File.new(filepath) || NullObject.new
      end
    end
  end

  def get_style
    Style.get_arg @row
  end

  def get_genres
    Genre.get_arg @row
  end

end

