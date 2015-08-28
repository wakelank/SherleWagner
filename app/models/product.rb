require 'english'
require 'csv'

class Product < ActiveRecord::Base
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :colors
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :styles
  has_and_belongs_to_many :product_types
  has_and_belongs_to_many :product_sub_types
  has_one :basin_design
  has_one :ceiling_lights_design
  has_one :console_counter_vanity_design
  has_one :door_trim_design
  has_one :lever_design
  has_one :overall_color
  has_one :wall_lights_design
  has_one :wall_paper_design
  has_one :wall_trim_design
  has_one :water_closet_handle_design

  belongs_to :product_type
  belongs_to :product_sub_type  

  belongs_to :product_group

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

  def self.upload_product_file(file)
    CSV.foreach(file.path, col_sep: ",", encoding: "MacRoman", headers: true) do |row|
      if $INPUT_LINE_NUMBER >= 5
        $INPUT_LINE_NUMBER ? line_num = $INPUT_LINE_NUMBER : line_num = 0
        name = row["PRODUCT NAME-Revised"]
        long_description = row["PRODUCT DESCRIPTION"]
        number = row["CODE under Product Name"]
        product = Product.create(name: name, long_description: long_description, number: number)
        if ProductGroup.where(name: name).first
          product_group = ProductGroup.where(name: name).first
        else
          product_group = ProductGroup.create(name: name)
        end
        product.product_group = product_group
        begin
          image_url = "http://s3.amazonaws.com/sherle-wagner/temp/#{row['IMAGE FILE']}.jpg"
          product.image = URI.parse(image_url)
        rescue
        end
        row.each do |header, value|
          if value && value.downcase.strip == 'x'
            if header
              headerArr = header.split('-')
              if headerArr[0] == "Materials"
                material = Material.where('lower(name) = ?',headerArr[1].downcase.strip).first
                color = Color.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                  product.colors << color
                  product.materials << material
                rescue
                end

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

