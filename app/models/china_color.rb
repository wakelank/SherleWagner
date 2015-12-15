class ChinaColor < ActiveRecord::Base
 # has_and_belongs_to_many :china_colored_product_groups, class_name: 'ProductGroups', join_table: 'china_colors_product_groups'
  has_and_belongs_to_many :china_colored_products, class_name: 'Products', join_table: 'china_colors_products'

  INDICATOR = "CC"

  def self.add_china_colors_to(product)
    product.china_colors = ChinaColor.all
  end


end
