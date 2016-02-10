class Material < ActiveRecord::Base
#  has_and_belongs_to_many :materialed_product_groups, class_name: 'Materials', join_table: 'materials_product_groups'
  has_and_belongs_to_many :materialed_products, class_name: 'Materials', join_table: 'materials_products'
  #has_and_belongs_to_many :inserted_products, class_name: 'Materials', join_table: 'inserts_products'

  @@codes_arr 

  def self.codes
    @@codes_arr ||= self.pluck(:code).uniq.compact
  end

  def self.add_materials_to(product, code)
    if code
      product.materials = Material.where(code: code)
    end
  end

  def burnished?
    identifier == "15PL" ||
      identifier == "14GP" ||
      identifier.last(2) == "-G" ||
      identifier.last(2) == "-P"
  end
  
  def polished?
    identifier == "17HP" ||
      identifier.last(2) == "HP"
  end
  
end

