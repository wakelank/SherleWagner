class Filter < ActiveRecord::Base
  #has_many :filter_product_group_values
  #has_many :filter_values, through: :filter_product_group_values
  #has_many :product_groups, through: :filter_product_values
  has_many :filter_values
  has_and_belongs_to_many :product_sub_types

  extend CanExtractFromFile
  HEADER = ""

  def filter_hash
    binding.pry
    output_hash[:filter_name] = self.name
    output_hash[:filter_values] = self.filter_values
    output_hash
  end

  def extract_from(row)
    arr = []
    arr << row["FILTERS"] || ""
    arr << row["FILTERS2"] || ""
    arr
  end

  def case_insensitive_find(find_mes)
    find_mes.each do |find_me|
      self.where('lower(name) = ?', find_me.downcase.strip).first || self.first 
    end
  end


end
