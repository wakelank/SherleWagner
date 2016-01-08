require 'english'
require 'csv'
require 'find'

class Product < ActiveRecord::Base
  extend ImageFilePath


#  belongs_to :product_group
  belongs_to :product_type
  belongs_to :product_sub_type
  has_many :product_configurations
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :filter_values
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_products
  has_and_belongs_to_many :china_colors, class_name: 'ChinaColor', join_table: :china_colors_products
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_products
  has_and_belongs_to_many :styles
  has_and_belongs_to_many :compilations
  belongs_to :associated_collection, class_name:  "Style"

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  def self.new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      args = {}
      args[:name] = self.get_name_from row
      args[:number] = self.get_generic_number_from row
      if args[:number] != "TITLE-XX"
        args[:product_type] = ProductType.get_arg row
        args[:product_sub_type] = ProductSubType.get_arg row
        image_name = self.get_image_name_from row
    #    images_path = "/Users/ph1am/Desktop/SW website/images1"
        # images_path = "/Users/wake/Documents/Work/SherleWagner/images"
         images_path = self.image_file_path
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

        begin

          product = Product.new(args)
          Finish.add_finishes_to product if product.needs_finishes? 
          ChinaColor.add_china_colors_to product if product.needs_china_colors?
          Material.add_materials_to(product, product.needed_materials)

          coll = product.find_associated_collection
          if !coll.nil?
            product.associated_collection = coll 
          end
          product.styles << style
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

  end

  def find_associated_collection
    collection =  Style.all.select { |collection| self.name.include? collection.name }.last
    return collection || NullObject.new
  end


  def add_associated_collection collection
    self.associated_collection = collection if !collection.nil?
  end

  def needs_finishes?
    self.number.include? Finish::INDICATOR
  end

  def needs_china_colors?
    self.number.include? ChinaColor::INDICATOR
  end

  def needed_materials
    arr = Material.codes.select do |code|
      self.number.include? code
    end
    if arr.include? "STONE"
      arr << "ONYX"
      arr < "MARBL"
    end
    arr 
  end

  def associated_collection_or_null
    self.associated_collection || NullObject.new
  end



  def self.get_name_from(row)
    row["GENERIC PRODUCT NAME _ Revised"] || "no name"
  end

  def self.get_generic_number_from(row)
    row["Generic Product Number"] || "no product number"
  end

  def self.get_image_name_from(row)18
    name = row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
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

  def filter_value_names
    arr = filter_values.map do |filter_value|
      filter_value.snake_case_name
    end
    arr.concat genres.pluck(:name)
    arr << "Semi_Precious" if (number.include?("SLSL") || number.include?("SEMI"))
    arr << "Metal" if number.include?("XX")
    arr << "Onyx" if number.include?("ONYX")
    arr << "Marble" if (number.include?("MARBLE") || number.include?("STONE"))
    arr << "China" if (number.include?("HANDPAINTED") || number.include?("CHINAMETAL") || number.include?("HANDDECORATED"))
    arr << "Stone" if (number.include?("STONE") || number.include?("SLSL") || number.include?("SEMI") || number.include?("ONYX"))
    arr << "Banded" if (number.incude?("CHINAMETAL"))
    arr << "Burnished" if (number.include?("15PL") ||
                           number.include?("14GP") ||
                           number.include?("G") ||
                           number.inlcude?("P")
                          )
    arr << "Solid" if (number.include?("GLAZE"))
    arr << "Polished" if (number.include?("17HP") ||
                          number.include?("HP")
                         )

    arr
  end


# searchable do
#     text :name
#     # text :product_sub_type do
#     #      product_sub_type.name
#     #    end
#     #    text :product_type do
#     #      product_type.name
#     #    end
    
# end


  def china_colors?
    self.china_colors.length > 0
  end

  def product_configurations_except_first
    product_configurations[1..product_configurations.length-1]
  end

end


