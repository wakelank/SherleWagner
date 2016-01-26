require 'english'
require 'csv'
require 'find'

class Product < ActiveRecord::Base


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
  belongs_to :associated_collection, class_name:  "Style"

has_many :in_compilation_relationships,
    foreign_key: :component_id,
    class_name: "CompilationRelationship"
  has_many :compilations, through: :in_compilation_relationships
#thing


  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  validates :name, presence: true
  validates :number, presence: true

  before_create :add_associated_collection
  after_create :add_finishes, :add_material, :add_china_color

  def self.new_upload_product_file(file)
    file_upload_manager = FileUploadManager.new file
    file_upload_manager.upload
  end

  def compilation?
    components.count > 0
  end

  def ornate?
    genres.pluck(:name).include?("Ornate")
  end

  def component?
    compilations.count > 0 && name_only_products > 0
  end

  def all_components
    components + name_only_products
  end

  def all_compilations
    compilations.map { |comp| comp.product }
  end

  def components
    product_configurations.map { |config| config.components }.flatten
  end

  def compilations_number_string
    compilations.map { |comp| comp.number }.join(" ")
  end

  def name_only_products
    product_configurations.map { |config| config.name_only_products }.flatten
  end

  def add_component component
    if component.class.name == "Product"
      self.components << component
    else
      self.name_only_products << component
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

  def add_configuration(configuration)
    if !configuration.nil? 
      self.product_configurations << configuration
    end
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
      filter_value.filter_name_and_value
    end
    #arr.concat genres.pluck(:name)
    arr.concat genres.map { |genre| "Styles_#{genre.name}" }
    arr << "Materials_Semi_Precious" if (number.include?("SLSL") || number.include?("SEMI"))
    arr << "Materials_Metal" if number.include?("XX")
    arr << "Materials_Onyx" if number.include?("ONYX")
    arr << "Materials_Marble" if (number.include?("MARBLE") ||
                        number.include?("STONE"))
    arr << "Materials_China" if (number.include?("HANDPAINTED") ||
                       number.include?("CHINAMETAL") ||
                       number.include?("HANDDECORATED"))
    arr << "Materials_Stone" if (number.include?("STONE") || number.include?("SLSL") ||
                       number.include?("SEMI") ||
                       number.include?("ONYX"))
    arr << "Burnished_&_Polished_Banded" if (number.include?("CHINABANDED"))
    arr << "Burnished_&_Polished_Solid" if (number.include?("CHINAMETAL"))
    arr << "Burnished_&_Polished_Decorated" if (number.include?("METALDECO"))
    arr << "Glazed_Solid" if (number.include?("GLAZE"))
    arr << "Glazed_Hand_Painted" if (number.include?("HANDPAINTED"))
    arr << "Glazed_Hand_Decorated" if (number.include?("CHINADECO"))

    arr
  end

  def burnished?
    identifiers = self.materials.select { |material| material.burnished? }.length > 0
  end

def polished?
    identifiers = self.materials.select { |material| material.polished? }.length > 0
  end

# searchable do
#     text :name
#  text :product_sub_type do
#      product_sub_type.name
#    end
#        text :product_type do
#          product_type.name
#        end
    
# end


  def china_colors?
    self.china_colors.length > 0
  end

  def product_configurations_except_first
    product_configurations[1..product_configurations.length-1] || []
  end

  def add_finishes
    Finish.add_finishes_to self if self.needs_finishes? 
  end

  def add_china_color
    ChinaColor.add_china_colors_to self if self.needs_china_colors?
  end
  
  def add_material
    Material.add_materials_to(self, self.needed_materials)
  end

  def add_associated_collection
    coll = self.find_associated_collection
    if !coll.nil?
      self.associated_collection = coll 
    end

  end


end


