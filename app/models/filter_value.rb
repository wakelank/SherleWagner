class FilterValue < ActiveRecord::Base
  belongs_to :filter
  has_and_belongs_to_many :product_groups
  has_and_belongs_to_many :products
  #has_many :filter_product_group_values
  #has_many :filters, through: :filter_product_group_values
  #has_many :product_groups, through: :filter_product_values
  
  include SnakeCase

  def self.get_arg(row)
    result = self.extract_from row
    case_insensitive_find(result)
  end

  def self.extract_from(row)
    arr = []
    arr << (row["FILTERS"] || NullObject.new)
    arr << (row["FILTERS2"] || NullObject.new)
    arr
  end

  def self.case_insensitive_find(find_mes)
    arr = []
    find_mes.each do |find_me|
      result = self.where('lower(name) = ?', find_me.downcase.strip).first 
      if !result.nil?
        arr << result
      end
    end
    arr
  end

  def snake_case_name
    snake_case name
  end

end
