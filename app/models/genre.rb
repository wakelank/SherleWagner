class Genre < ActiveRecord::Base
  has_many :styles
  has_and_belongs_to_many :products
end
