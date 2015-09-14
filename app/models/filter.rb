class Filter < ActiveRecord::Base
  has_many :filter_product_values
  has_many :filter_values, through: :filter_product_values
  has_many :products, through: :filter_product_values
end
