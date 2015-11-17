class ProductSubType < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_groups
  has_many :products
  

  def four_products
    self.products.all.limit 4
  end

  def self.extract_from(row)
    row["SUB FOLDER"] || 'no prod type'
  end

  def self.find_product_type(prod_type_name)
    ProductSubType.where('lower(name) = ?', prod_type_name.downcase.strip).first || ProductSubType.first 
  end

  def self.get_arg(row)
    prod_type = ProductSubType.extract_from row
    find_product_type(prod_type)
  end

end
