class FilterValue < ActiveRecord::Base
  belongs_to :filter
  has_and_belongs_to_many :product_groups
  #has_many :filter_product_group_values
  #has_many :filters, through: :filter_product_group_values
  #has_many :product_groups, through: :filter_product_values
end
