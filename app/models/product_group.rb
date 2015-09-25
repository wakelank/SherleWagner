class ProductGroup < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_product_groups
end
