class ProductSubType < ActiveRecord::Base
  belongs_to :product_type
#  has_many :product_groups
  has_many :products
  has_and_belongs_to_many :filters
  
  extend CanExtractFromFile

  HEADER = "SUB FOLDER"

  def four_products
    self.products.all.limit 4
  end

  def filters_ordered
    self.filters.order(:id)
  end

end
