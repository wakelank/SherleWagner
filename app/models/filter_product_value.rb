class FilterProductValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :filter
  belongs_to :filter_value

  validates :filter, uniqueness: { scope: :product }
  validates :filter_value, uniqueness: { scope: [:product, :filter] }
end
