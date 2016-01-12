require 'english'
require 'paperclip_stub.rb'
require 'csv'
require 'find'

class FileUploadManager
  extend ImageFilePath

  def initialize file
    @file = file
  end

  def upload
    new_upload_product_file @file
  end

  def new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new(row)
      args = {}
      args[:name] = data_row.get_name_from 
      args[:number] = self.get_generic_number_from row
      image_name = self.get_image_name_from row
        args[:product_type] = ProductType.get_arg row
        args[:product_sub_type] = ProductSubType.get_arg row
    #    images_path = "/Users/ph1am/Desktop/SW website/images1"
         images_path = "/Users/wake/Documents/Work/SherleWagner/images"
        # images_path = image_file_path
        image_file = NullObject.new
        style = Style.get_arg row
        filters = FilterValue.get_arg row
        genres= Genre.get_arg row
        product_configuration = ProductConfiguration.get_arg row
        Find.find(images_path) do |filepath|
          if File.basename(filepath) == image_name
            image_file = File.new(filepath) || NullObject.new
          end
        end
        args[:image] = image_file if !image_file.nil?

      if image_name != "no name"
        begin

          if args[:number] == "TITLE-XX"
            args[:number] = row["IMAGE FILE"]
          end
          product = Product.new(args)
          Finish.add_finishes_to product if product.needs_finishes? 
          ChinaColor.add_china_colors_to product if product.needs_china_colors?
          Material.add_materials_to(product, product.needed_materials)

          coll = product.find_associated_collection
          if !coll.nil?
            product.associated_collection = coll 
          end
          product.styles << style if !style.nil?
          product.filter_values.concat filters
          product.genres.concat genres

          if Product.exists?(number: product.number)
            product = Product.find_by(number: args[:number])
          end

          product.product_configurations << product_configuration if !product_configuration.nil?
          product.save if product.valid?
        rescue
          binding.pry
        end
      end
    end
    compilations = get_components_hash_from file
    assign_components compilations

  end
  
  def assign_components compilations
    compilations.each do |compilation|
      product = Product.find_by(number: compilation[:number])
      compilation[:components].each do |component|
        component_obj = Product.where('number like ?', "#{component}%").first
        if !product.nil? && !component_obj.nil?
          product.products << component_obj
          component_obj.products << product
        end
      end
      product.save
    end
  end

  def get_components_hash_from file
    compilations = []
    compilation = {}
    make_compilation = false
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      if row["Generic Product Number"] == "TITLE-XX"
        if make_compilation == true
          compilations << compilation
          compilation = {}
        end
        make_compilation = true
        compilation[:number] = row["IMAGE FILE"]
        compilation[:components] = []
      elsif row["IMAGE FILE"].blank? && make_compilation
        compilation[:components] << row["CODE under Product Name"]
      else
        if make_compilation
          compilations << compilation
          compilation = {}
        end
        make_compilation = false
      end
    end
    if make_compilation
      compilations << compilation
    end
    compilations
  end
  
  def get_name_from(row)
    row["GENERIC PRODUCT NAME _ Revised"] || "no name"
  end

  def get_generic_number_from(row)
    row["Generic Product Number"] || "no product number"
  end

  def get_image_name_from(row)
    name = row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
  end

end
