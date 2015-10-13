class ProductGroup < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_product_groups
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_product_groups
  #has_and_belongs_to_many :genres
  has_and_belongs_to_many :styles
  belongs_to :product_type
  belongs_to :product_sub_type
  #has_many :filter_product_group_values
  #has_many :filters, through: :filter_product_group_values
  #has_many :filter_values, through: :filter_product_group_values
  has_and_belongs_to_many :filter_values
  

  def add_materials(material_code)
    begin
      self.materials.concat Material.where(code: material_code)
      self.save
    rescue
      binding.pry
    end
  end

  def self.custom_create(number, name, product_type, product_sub_type)
    if !!name
      begin
        new_product_group = self.new(number: number, name: name, product_type: product_type, product_sub_type: product_sub_type)
        if new_product_group.number.include?('-XX')
          new_product_group.finishes = Finish.all
        end
        Material.codes.each do |code|
          new_product_group.add_materials(code) if new_product_group.number.include? "-#{code}"
        end
        new_product_group.save
      rescue
        binding.pry
      end
      new_product_group
    end
  end

 # def filters
 #   self.filter_values
 # end

#  def filter_names
#    f_names = []
#    self.filter_values.each do |filter_value|
#      f_names << filter_value.filter.name
#    end
#    f_names.uniq
#  end
  def get_filter_values
    self.filter_values.uniq
  end

  def get_filters
    filter_arr = []
    filter_vals = self.filter_values
    filter_vals.each do |filter_val|
      filter_arr << filter_val.filter
    end
    filter_arr.uniq
  end

  def filter_hashes
    f_hashes = []
    self.get_filters.each do |filter|
      f_hashes << filter.filter_hash
    end
    f_hashes
  end

searchable do
    text :name
end
  

end
