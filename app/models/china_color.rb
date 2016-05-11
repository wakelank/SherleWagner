class ChinaColor < ActiveRecord::Base
 # has_and_belongs_to_many :china_colored_product_groups, class_name: 'ProductGroups', join_table: 'china_colors_product_groups'
  has_and_belongs_to_many :products

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }


  INDICATOR = "CC"
  @@china_colors_array = nil 

  def self.china_colors_identifiers
    if @@china_colors_array.nil?
      @@china_colors_array = self.pluck(:identifier).uniq.compact
    end
    @@china_colors_array
  end

  def self.add_china_colors_to(product)
    if product.number.include? "HANDPAINTED"
      product.china_colors = ChinaColor.where(name: "White").where(name: "Sand")
    else
      product.china_colors = ChinaColor.all
    end

  end


end
