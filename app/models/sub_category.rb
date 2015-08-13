class SubCategory < ActiveRecord::Base
  has_and_belongs_to_many :Products
end
