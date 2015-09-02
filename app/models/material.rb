class Material < ActiveRecord::Base
  has_and_belongs_to_many :materialed_products, class_name: 'Materials', join_table: 'materials_products'
  has_and_belongs_to_many :inserted_products, class_name: 'Materials', join_table: 'inserts_products'
end
