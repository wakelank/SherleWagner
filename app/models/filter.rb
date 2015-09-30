class Filter < ActiveRecord::Base
  #has_many :filter_product_group_values
  #has_many :filter_values, through: :filter_product_group_values
  #has_many :product_groups, through: :filter_product_values
  has_many :filter_values


  def filter_hash
    output_hash = {}
    output_hash[:filter_name] = self.name
    output_hash[:filter_values] = self.filter_values
    output_hash
  end

end
