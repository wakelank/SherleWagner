
#require 'paperclip_stub.rb'

require 'csv'
require 'find'

extend ImageFilePath

# IMAGES_PATH = "/Users/ph1am/Desktop/SW_website/images1"
# IMAGES_PATH = "/Users/wake/Documents/Work/SherleWagner/images"
#IMAGES_PATH = image_file_path

class FileUploadManager
  extend ImageFilePath

  def initialize file
    @file = file
    @bucket = get_bucket
    @bucket_objects = get_bucket_objects
    @images_on_aws = @bucket_objects.keys
  end

  def upload
    new_upload_product_file @file
  end

  def new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new(row)
      product = Product.new(data_row.product_args)
      product.image = get_image_from_aws data_row.get_image_name

      if !Product.uber_exists?(product) && !data_row.component?
        begin

          # style = data_row.get_style
          # filters = data_row.get_filters
          # genres= data_row.get_genres
          # product_configuration = data_row.jget_product_configuration
          product.styles.concat data_row.get_style
          product.filter_values.concat data_row.get_filters
          product.genres.concat data_row.get_genres
          product.add_configuration data_row.get_product_configuration
          product.save if product.valid?
        rescue
          #binding.pry
        end

      elsif !data_row.component?
        product = data_row.product
        if !product.nil?
          product.add_configuration data_row.get_product_configuration
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

  def get_image image_name
    image_file = NullObject.new
    Find.find(IMAGES_PATH) do |filepath|
      if File.basename(filepath) == image_name
        image_file = File.new(filepath) || NullObject.new
      end
    end
    image_file
        
  end

  def get_image_from_aws image_name
    if @images_on_aws.include? image_name
      begin
        @bucket_objects[image_name]
      rescue
        #binding.pry
      end
    else
      NullObject.new
    end
  end

  def get_bucket
    begin 
      bucket = AWS::S3.new().buckets["sw-raw-images"]
    rescue
      bucket = NullBucket.new
      #binding.pry
    end
    bucket
  end

  def get_bucket_objects
    obj_hash = {}
    begin
      @bucket.objects.each do |obj|

        image_name = obj.key.split('/').last
        image_url = obj.public_url.to_s
        obj_hash[image_name] = image_url

      end
    rescue
      #binding.pry
    end
    obj_hash
  end

end
