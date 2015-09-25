class Finish < ActiveRecord::Base
  has_and_belongs_to_many :finished_product_groups, class_name: 'ProductGroups', join_table: 'finishes_product_groups'
  has_and_belongs_to_many :accented_products, class_name: 'Products', join_table: 'accents_products'
end
