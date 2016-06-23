class ProductType < ActiveRecord::Base
  has_many :product_sub_types
  # has_many :product_groups
  has_many :products
  

  #extend CanExtractFromFile

  HEADER = "MAIN"

  def self.extract_from(row)
    row[self::HEADER] || "NONE"
  end

  def self.case_insensitive_find(find_me)
    self.where('lower(name) = ?', find_me.downcase.strip).first || self.first 
  end

  def self.get_arg(row)
    result = self.extract_from row
    case_insensitive_find(result)
  end

  def self.assign_attribute(args)
    product = args[:product] || NullObject.new
    row = args[:row] || NullObject.new
    result = self.extract_from row
    case_insensitive_find(result)
    product.product_type = result
  end
    
end
