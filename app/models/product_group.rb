class ProductGroup < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_product_groups
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_product_groups
  has_and_belongs_to_many :china_colors, class_name: 'ChinaColor', join_table: :china_colors_product_groups
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :styles
  belongs_to :product_type
  belongs_to :product_sub_type
  has_and_belongs_to_many :filter_values

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true
  validates :product_type, presence: true
  validates_associated :product_type
  validates :product_sub_type, presence: true
  validates_associated :product_sub_type

  
  before_destroy { |record| Product.destroy_all "product_group_id= #{record.id}" }

  def add_materials(material_code)
    begin
      self.materials.concat Material.where(code: material_code)
      self.save
    rescue
      binding.pry
    end
  end

  def self.custom_create(args)
    if !!name
      begin
        new_product_group = self.new(number: args[:number],
                                     name: args[:name],
                                     product_type: args[:product_type] || ProductType.first,
                                     product_sub_type: args[:product_sub_type] || ProductSubType.first)
        if new_product_group.number.include?('-XX')
          new_product_group.finishes = Finish.all
        end
        if new_product_group.number.include?('-CC')
          new_product_group.china_colors = ChinaColor.all
        end
        
        Material.codes.each do |code|
          new_product_group.add_materials(code) if new_product_group.number.include? "-#{code}"
        end
        new_product_group.save if new_product_group.valid?
      rescue
        binding.pry
      end
      new_product_group
    end
  end

  def self.first_or_custom_create(args)
    if self.where(number: args[:number]).length > 1
      self.where(number: args[:number]).first
    else
      self.custom_create(args)
    end
  end

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

  def base_number
    self.number.split('-')[0]
  end


searchable do
    text :name
    text :product_sub_type do
         product_sub_type.name
       end
       text :product_type do
         product_type.name
       end
    
end
  

end
