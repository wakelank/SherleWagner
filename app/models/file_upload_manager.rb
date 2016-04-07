
require 'csv'
require 'find'

#extend ImageFilePath

# IMAGES_PATH = "/Users/ph1am/Desktop/SW_website/images1"
# IMAGES_PATH = "/Users/wake/Documents/Work/SherleWagner/images"
#IMAGES_PATH = image_file_path

class FileUploadManager
#  extend ImageFilePath

  def initialize file
    @file = file
    @bucket
    @bucket_objects
    @images_on_aws
    @materials_array
    @black_and_white_bucket
    @color_bucket
  end

  def upload
    new_upload_product_file @file
  end

  def new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new(row)
      product = Product.new(data_row.product_args)
      begin
        #product.image = black_and_white_bucket.get_image_from_aws(data_row.get_image_name)
        product.image = get_product_image(data_row, product)
        product.other_images << color_bucket.get_images_from_aws(get_other_potential_images_for(product))
      rescue
      end
      if !Product.uber_exists?(product) && !data_row.component?
        begin

          product.styles.concat data_row.get_style
          product.filter_values.concat data_row.get_filters
          product.genres.concat data_row.get_genres
          product.add_configuration(get_product_configuration(data_row))
          product.save if product.valid?
        rescue
          binding.pry

        end

      elsif !data_row.component?
        product = data_row.product
        if !product.nil?
          product.add_configuration get_product_configuration data_row
          product.save if product.valid?
        end


      end

    end
    set_compilations file

  end

  def get_product_image(data_row, product)
    image = black_and_white_bucket.get_image_from_aws(data_row.get_image_name)
    if image.nil?
      other_images = black_and_white_bucket.get_images_from_aws(get_other_potential_images_for(product))
      other_image = !other_images.empty? ? other_images.first : nil
      return other_image.image if !other_image.nil?
    else
      return image
    end
  end

  def set_compilations(file)
    current_compilation = NullObject.new
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new row
      if !data_row.component?
        current_compilation = data_row.configuration
      else
        component = data_row.component ||
          NameOnlyProduct.find_or_create_by(name: data_row.get_generic_name)
        if !component.nil? && !current_compilation.nil?
          current_compilation.add_component component
          current_compilation.save
        end
      end
    end
  end

  private

  def get_product_configuration data_row
    configuration = ProductConfiguration.new(data_row.configuration_args)
    begin
      configuration.image = color_bucket.get_image_from_aws(data_row.get_image_name)
      if configuration.image == NullObject
        configuration.image = black_and_white_bucket.get_image_from_aws(data_row.get_image_name)
      end
    rescue
    end

    configuration
  end

  def get_image image_name
    image_file = NullObject.new
    Find.find(IMAGES_PATH) do |filepath|
      if File.basename(filepath) == image_name
        image_file = File.new(filepath) || NullObject.new
      end
    end
    image_file

  end

  def materials_array
    @materials_array ||= Material.materials_arr
  end

  def get_other_potential_images_for product
    images = []
    materials_array.each do |material|
      if product.number.include? material[:code]
        material[:identifiers].each do |material_ident|
            Finish.finishes_identifiers.each do |finish_ident|
              ChinaColor.china_colors_identifiers.each do |china_ident|
                image_name = product.number.sub(material[:code], material_ident) + ".jpg"
                image_name.sub!("XX", finish_ident)
                image_name.sub!("CC", china_ident)
                images << image_name
              end
            end
          end
        end
      end
    images.uniq
  end



  def color_bucket
      @color_bucket ||= AwsHelper.new('sw-raw-images-color')
  end
  def black_and_white_bucket
      @black_and_white_bucket ||= AwsHelper.new('sw-raw-images')
  end
end
