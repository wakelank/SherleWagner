class Filter < ActiveRecord::Base
  #has_many :filter_product_group_values
  #has_many :filter_values, through: :filter_product_group_values
  #has_many :product_groups, through: :filter_product_values
  has_many :filter_values
end
