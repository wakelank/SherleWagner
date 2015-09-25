class ProductType < ActiveRecord::Base
  has_many :product_sub_types
  has_many :product_groups
end
