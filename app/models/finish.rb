class Finish < ActiveRecord::Base
  has_and_belongs_to_many :finished_products, class_name: 'Products', join_table: 'finishes_products'
  has_and_belongs_to_many :accented_products, class_name: 'Products', join_table: 'accents_products'
end
