
#require 'paperclip_stub.rb'

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
  end

  def upload
    new_upload_product_file @file
  end

  def new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new(row)
      product = Product.new(data_row.product_args)
      product.image = get_image_from_aws data_row.get_image_name
      product.other_images << get_images_from_aws(get_other_potential_images_for(product))

      if !Product.uber_exists?(product) && !data_row.component?
        begin

          product.styles.concat data_row.get_style
          product.filter_values.concat data_row.get_filters
          product.genres.concat data_row.get_genres
          product.add_configuration get_product_configuration data_row
          product.save if product.valid?
        rescue
          
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
    configuration.image = get_image_from_aws data_row.get_image_name
  
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

  def get_image_from_aws image_name
    if images_on_aws.include? image_name
      begin
        bucket_objects[image_name]
      rescue
        
      end
    else
      NullObject.new
    end
  end

  def get_images_from_aws image_name_arr
    image_name_arr.map! do |name|
      image = get_image_from_aws name
    end
    image_name_arr.select! do |image|
      image.class != NullObject
    end
    image_name_arr.map do |image|
      other_image = OtherImage.new
      other_image.image = image
      other_image
    end
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

  def images_on_aws
    @images_on_aws ||= bucket_objects.keys
  end

  def bucket
    if @bucket.nil?
      begin 
        @bucket = AWS::S3.new().buckets["sw-raw-images"]
      rescue
        @bucket = NullBucket.new
        
      end
    end
    @bucket
  end

  def bucket_objects
    if @bucket_objects.nil?
      @bucket_objects = {}
      begin
        bucket.objects.each do |obj|

          image_name = obj.key.split('/').last
          image_url = obj.public_url.to_s
          @bucket_objects[image_name] = image_url

        end
      rescue
        
      end
    end
    @bucket_objects
  end

end
