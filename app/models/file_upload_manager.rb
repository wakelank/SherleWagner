require 'english'
# require 'paperclip_stub.rb'
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
      product = Product.new(data_row.product_args)


      if !Product.exists?(number: product.number) && !data_row.component?
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
          binding.pry
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
        current_compilation = data_row.product
      else
        component = data_row.component ||
          NameOnlyProduct.create(name: data_row.get_generic_name)
        if !component.nil? && !current_compilation.nil?
          current_compilation.add_component component
          current_compilation.save
        end
      end
    end
  end

end
