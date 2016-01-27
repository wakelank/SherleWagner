class FilterValue < ActiveRecord::Base
  belongs_to :filter
  has_and_belongs_to_many :products
  
  include SnakeCase

  def self.get_filter_values(args)
    args[:sub_type].filter_values.select { |fv| args[:values].include? fv.name.downcase }
#    arr = []
#    args[:values].each do value
#      arr << FilterValue.where(filter.product_sub_type: args[:product_sub_type]).
#        where('lower(name) = ?', value)
#    end
#    arr
  end

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

  def filter_name_and_value
    snake_case(self.filter.name + '_' + self.name)
  end

end
