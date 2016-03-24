class ProductSubType < ActiveRecord::Base
  belongs_to :product_type
#  has_many :product_groups
  has_many :products
  has_and_belongs_to_many :filters
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  extend CanExtractFromFile

  HEADER = "SUB FOLDER"

  def four_products
    self.products.all.limit 4
  end

  def filters_ordered
    self.filters.order(:id)
  end

  def filter_values
    filters.map{ |f| f.filter_values }.flatten

  end

end
