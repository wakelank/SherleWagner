require 'english'
require 'csv'

class Product < ActiveRecord::Base
  belongs_to :product_group
  belongs_to :product_type
  belongs_to :product_sub_type
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :filter_values
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_products
  has_and_belongs_to_many :china_colors, class_name: 'ChinaColor', join_table: :china_colors_products
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_products
  has_and_belongs_to_many :styles

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  def self.new_upload_product_file(file)

    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
        #name = row["GENERIC PRODUCT NAME _ Revised"] || "no name"
        #generic_product_number = row["Generic Product Number"] || "no product number"
        product_number = row["IMAGE FILE"] || "no image"
        product_type = row['MAIN'] || "no product type"
        product_sub_type = row['SUB FOLDER'] || "no product sub type"
        style_name = row["STYLES"] || ""
        filter_name = row["FILTERS"] || ""
        filter_name2 = row["FILTERS2"] || ""
        genre_names = row["GENRES"] || ""
        args = {}
        args[:product_type] = ProductType.get_arg row
        args[:product_sub_type] = ProductSubType.get_arg row
        args[:name] = self.get_name_from row
        args[:generic_product_number] = self.get_generic_number_from row
        

          begin
        #    product_type =ProductType.where('lower(name) = ?', product_type.downcase.strip).first 
         #   product_sub_type = ProductSubType.where('lower(name) =?', product_sub_type.downcase.strip).first 
          #    product_group_args = { number: generic_product_number,
           #                          name: name, 
            #                         product_type: product_type, 
             #                        product_sub_type: product_sub_type }
            #  product_group = ProductGroup.first_or_custom_create(product_group_args)
            product = Product.new(name: args[:name], 
                                     number: args[:generic_product_number], 
                                     product_type: args[:product_type], 
                                     product_sub_type: args[:product_sub_type]
                                 )
            if product.number.include?('-XX')
              product.finishes = Finish.all
            end

            if product.number.include?('CC')
              product.china_colors = ChinaColor.all
            end

            Material.codes.each do |code|
              product.add_materials(code) if product.number.include? "-#{code}"
            end

            product.save if product.valid?
          rescue
            binding.pry
          end

          begin
                style = Style.where(name: style_name.downcase.strip).first_or_create
                product.styles << style
              if !filter_name.blank?
                filter_value = FilterValue.where('lower(name) = ?', filter_name.downcase.strip).first
                product.filter_values << filter_value if !filter_value.nil?
              end
              if !filter_name2.nil? && filter_name2 !=""
                filter_value = FilterValue.where('lower(name) = ?', filter_name2.downcase.strip).first
                product.filter_values << filter_value if !filter_value.nil?
              end
              if !genre_names.blank?
                genre_names.split(',').each do |genre_name|
                  genre = Genre.where('lower(name) = ?', genre_name.downcase.strip)  
                  product.genres << genre if (!genre.nil?)
                end
              end
              #product_group.save

          rescue
            binding.pry
          end
        end
  end

  def self.get_name_from(row)
    row["GENERIC PRODUCT NAME _ Revised"] || "no name"
  end

  def self.get_generic_number_from(row)
    row["Generic Product Number"] || "no product number"
  end



  
  def add_materials(material_code)
    begin
      self.materials.concat Material.where(code: material_code)
      self.save
    rescue
      binding.pry
    end
  end

  def get_filter_values
    self.filter_values.uniq
  end

  def get_filters
    filter_arr = []
    filter_vals = self.filter_values
    filter_vals.each do |filter_val|
      filter_arr << filter_val.filter
    end
    filter_arr.uniq
  end

  def filter_hashes
    f_hashes = []
    self.get_filters.each do |filter|
      f_hashes << filter.filter_hash
    end
    f_hashes
  end
end



class NonClass
  attr_accessor :name
  def initialize
    @name = "no name"
  end
end

class NonProductType < NonClass
  ProductType.first
end

class NonProductSubType < NonClass
  ProductSubType.first
end


class NonStyle < NonClass
end

class NonFilter < NonClass
  attr_accessor :filter_value
  def initialize
    @filter_value = "Non filter value"
  end

end

class NonGenre < NonClass
end


