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

  def self.custom_create(name)
    if !!name
      begin
        new_product_group = self.new(name: name)
        if new_product_group.name.include?('-XX')
          new_product_group.finishes = Finish.all
        end
        Material.codes.each do |code|
          new_product_group.add_materials(code) if new_product_group.name.include? "-#{code}"
        end
        new_product_group.save
      rescue
        binding.pry
      end
      new_product_group
    end
  end
  

end
