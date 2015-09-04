class Filter < ActiveRecord::Base
  has_many :filter_values
  has_many :products, through: :filter_values
end
