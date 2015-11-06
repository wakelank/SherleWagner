class ChinaColor < ActiveRecord::Base
  has_and_belongs_to_many :china_colored_product_groups, class_name: 'ProductGroups', join_table: 'china_colors_product_groups'
end
