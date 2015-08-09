class Product < ActiveRecord::Base
  belongs_to :Category
  belongs_to :Sub_category
end
