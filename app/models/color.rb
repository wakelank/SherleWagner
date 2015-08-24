class Color < ActiveRecord::Base
  belongs_to :material
  has_and_belongs_to_many :products

end
