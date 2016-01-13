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
        style = data_row.get_style
        filters = data_row.get_filters
        genres= data_row.get_genres
        product_configuration = data_row.get_product_configuration 

      if data_row.normal_product?
        begin

        #  if args[:number] == "TITLE-XX"
        #    args[:number] = row["IMAGE FILE"]
        #  end
          product = Product.new(data_row.product_args)
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

        #  if Product.exists?(number: product.number)
        #    product = Product.find_by(number: args[:number])
        #  end

          #product.product_configurations << product_configuration if !product_configuration.nil?
          product.product_configurations << data_row.get_product_configuration
          product.save if product.valid?

        rescue
          binding.pry
        end

        elsif data_row.configuration?
          product = data_row.product
          product.product_configurations << data_row.get_product_configuration
          product.save

        end
      end
    #compilations = get_components_hash_from file
    #assign_components compilations

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
