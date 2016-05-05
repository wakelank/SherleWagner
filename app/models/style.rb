class Style < ActiveRecord::Base

  include PgSearch
  multisearchable :against => [:name]

  belongs_to :genre
#  has_and_belongs_to_many :product_groups
  has_and_belongs_to_many :products
  has_many :environment_shot_styles
  has_many :environment_shots, through: :environment_shot_styles

  has_attached_file :image, styles: { medium: "100x100>" }, default_url: "/images/:style/missing_collection.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
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

