class ProductSubType < ActiveRecord::Base

  belongs_to :product_type
#  has_many :product_groups
  has_many :products
  has_and_belongs_to_many :filters
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  extend CanExtractFromFile

  HEADER = "SUB FOLDER"

  def five_products(admin = false)
    if admin
      self.products.all.order(:id).limit 5
    else
      self.products.where('image_file_name is not null').order(:id).limit 5
    end
  end

  def two_products
    self.products.all.order(:id).limit 2
  end

  def main_product
    products.all.order(:id).limit(1)
  end

  def filters_ordered
    self.filters.order(:id)
  end

  def filter_values
    filters.map{ |f| f.filter_values }.flatten

  end

end
  # def product_configurations(admin = false)
  #   if admin
  #     old_product_configurations
  #   else
  #     old_product_configurations.where('image_file_name is not null')
  #   end
  # end

