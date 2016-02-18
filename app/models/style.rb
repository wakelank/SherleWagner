class Style < ActiveRecord::Base
  belongs_to :genre
#  has_and_belongs_to_many :product_groups
  has_and_belongs_to_many :products

  extend CanExtractFromFile

  HEADER = "STYLES"

  def self.names
    self.pluck(:name)
  end

  def four_products
    self.products.all.limit 4
  end
#  def products
#    product_arr = []
#    self.products.each do |p|
#        name = p.name ? p.name : "none"
#        product_arr << p.name + " : " + name + "-" + p.number
#      end
#
#    product_arr
#
#  end



end

