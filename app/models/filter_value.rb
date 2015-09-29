class FilterValue < ActiveRecord::Base
  belongs_to :filter
  has_and_belongs_to_many :product_groups
end
