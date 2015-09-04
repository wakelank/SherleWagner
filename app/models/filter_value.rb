class FilterValue < ActiveRecord::Base
  belongs_to :filter
  belongs_to :product
end
