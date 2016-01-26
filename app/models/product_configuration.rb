
class ProductConfiguration < ActiveRecord::Base
  extend ImageFilePath

  belongs_to :product
  has_many :has_components_relationships,
    foreign_key: :compilation_id,
    class_name:"CompilationRelationship"
  has_many :components, through: :has_components_relationships
  has_and_belongs_to_many :name_only_products, :join_table => "name_only_prod_prod_configs"

  validates :number, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_configuration.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

  def self.get_arg(row)
    args = {}
    args[:number] = row["IMAGE FILE"] || NullObject.new() 
    args[:description] = row["NAME"] || NullObject.new() 
    image_name = self.get_image_name_from row
    images_path = "/Users/ph1am/Desktop/SW_website/images1"
      # images_path = "/Users/wake/Documents/Work/SherleWagner/images"
     # images_path = self.image_file_path
    image_file = NullObject.new
    Find.find(images_path) do |filepath|
      if File.basename(filepath) == image_name
        image_file = File.new(filepath) || NullObject.new
      end
    end
    args[:image] = image_file if !image_file.nil?

    product_configuration = ProductConfiguration.new(args) || NullObject.new
    if product_configuration.valid?
      product_configuration
    else
      logger.info "====================================="
      logger.info product_configuration.errors.messages
      NullObject.new
    end

  end

  def add_component component
    if component.class.name == "Product"
      self.components << component if !self.components.include? component
    else
      self.name_only_products << component if !self.name_only_products.include? component
    end
  end


  def self.get_image_name_from(row)
    name = row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
  end


end

