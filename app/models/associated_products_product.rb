class AssociatedProductsProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :associated_product, class_name: 'Product', foreign_key: 'associated_product_id'
end
