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


      if data_row.normal_product? || data_row.compilation?
        begin

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
    set_compilations file
    #compilations = get_components_hash_from file
    #assign_components compilations

  end
  def set_compilations(file)
    current_compilation = NullObject.new
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      data_row = DataRow.new row
      if data_row.compilation?
        current_compilation = data_row.product
      elsif data_row.normal_product?
        current_compilation = NullObject.new
      elsif data_row.component?
        component = data_row.component
        if !component.nil? && !current_compilation.nil?
          current_compilation.products << component
          component.products << current_compilation
          current_compilation.save
          component.save
        end
      end

    end
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
      data_row = DataRow.new row
      if data_row.compilation?
        if make_compilation == true
          compilations << new_compilation
          new_compilation = {}
        end
        make_compilation = true
        new_compilation[:number] = data_file.compilation_number
        new_compilation[:components] = []
      elsif data_row.compoment? && make_compilation
        new_compilation[:components] << data_row.component_number
      else
        if make_compilation
          compilations << new_compilation
          new_compilation = {}
        end
        make_compilation = false
      end
    end
    if make_compilation
      compilations << new_compilation
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
