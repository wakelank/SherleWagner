
class ProductConfiguration < ActiveRecord::Base

  belongs_to :product
  has_many :has_components_relationships,
    foreign_key: :compilation_id,
    class_name:"CompilationRelationship"
  has_many :components, through: :has_components_relationships
  has_and_belongs_to_many :name_only_products,
    :join_table => "name_only_prod_prod_configs"

  validates :number, presence: true

  has_attached_file :image, 
    styles: { medium: "300x300>", thumb: "100x100>", tall:"400x300>", square:"400x300>" }, 
    default_url: "/images/:style/missing_configuration.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }


  def add_component component
    if component.class.name == "Product"
      self.components << component if !self.components.include? component
    else
      self.name_only_products << component if !self.name_only_products.include? component
    end
  end

  def image_or_product_image
    if image.url.include? 'missing'
      product.image
    else
      image
    end
  end



end

