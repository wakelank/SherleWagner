class ProductSubType < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_groups
  has_many :products
  

  def four_products
    self.products.all.limit 4
  end


end
