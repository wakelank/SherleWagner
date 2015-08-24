class Material < ActiveRecord::Base
  has_many :colors
  has_and_belongs_to_many :products
end
