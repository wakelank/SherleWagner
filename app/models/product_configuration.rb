
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


  def add_component component
    if component.class.name == "Product"
      self.components << component if !self.components.include? component
    else
      self.name_only_products << component if !self.name_only_products.include? component
    end
  end


#  def self.get_image_name_from(row)
#    name = row["IMAGE FILE"] || "no image"
#    name = name + ".jpg" if name != "no image"
#    name
#  end
#

end

