require 'english'
require 'csv'

class Product < ActiveRecord::Base
  has_many :skus 
  has_many :materials, through: :skus
  has_many :colors, through: :skus
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :styles
  has_many :product_types, through: :skus
  has_many :product_sub_types, through: :skus
  has_many :basin_designs, through: :skus
  has_many :ceiling_lights_designs, through: :skus
  has_many :console_counter_vanity_designs, through: :skus
  has_many :door_trim_designs, through: :skus
  has_many :lever_designs, through: :skus
  has_many :overall_colors, through: :skus
  has_many :wall_lights_designs, through: :skus
  has_many :wall_paper_designs, through: :skus
  has_many :wall_trim_designs, through: :skus
  has_many :water_closet_handle_designs, through: :skus

  belongs_to :product_type
  belongs_to :product_sub_type  

  def self.upload_product_file(file)
    CSV.foreach(file.path, col_sep: ",", encoding: "MacRoman", headers: true) do |row|
      if $INPUT_LINE_NUMBER >= 5
        $INPUT_LINE_NUMBER ? line_num = $INPUT_LINE_NUMBER : line_num = 0
        name = row["PRODUCT NAME-Revised"]
        long_description = row["PRODUCT DESCRIPTION"]
        number = row["CODE under Product Name"]
        product = Product.create(name: name, long_description: long_description, number: number)
        row.each do |header, value|
          if value && value.downcase.strip == 'x'
            if header
              headerArr = header.split('-')
              if headerArr[0] == "Materials"
                material = Material.where('lower(name) = ?',headerArr[1].downcase.strip).first
                color = Color.where('lower(name) = ?', headerArr[2].downcase.strip).first
                sku = Sku.create(material: material, color:color)
                product.skus << sku
              elsif headerArr[0] == "COLLECTIONS"
                genre = Genre.where('lower(name) = ?', headerArr[1].downcase.strip).first
                style = Style.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                  product.genres << genre
                  product.styles << style
                rescue
                  binding.pry
                end
                product.save
              elsif headerArr[0] == "PRODUCTS"
                product_type = ProductType.where('lower(name) = ?', headerArr[1].downcase.strip).first
                product_sub_type = ProductSubType.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                  product.product_type = product_type
                  product.product_sub_type = product_sub_type
                  product.save
                rescue
                  binding.pry
                end
              end
            end
          end
        end
      end
    end
  end




end

