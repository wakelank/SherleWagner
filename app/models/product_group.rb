class ProductGroup < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_product_groups
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_product_groups

  def add_materials(material_code)
    begin
      self.materials.concat Material.where(code: material_code)
      self.save
    rescue
      binding.pry
    end
  end
end
