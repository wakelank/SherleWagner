class Material < ActiveRecord::Base
  has_and_belongs_to_many :materialed_product_groups, class_name: 'Materials', join_table: 'materials_product_groups'
  has_and_belongs_to_many :materialed_products, class_name: 'Materials', join_table: 'materials_products'
  #has_and_belongs_to_many :inserted_products, class_name: 'Materials', join_table: 'inserts_products'

  def self.codes
    self.pluck(:code).uniq.compact
  end

end

