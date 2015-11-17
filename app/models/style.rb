class Style < ActiveRecord::Base
  belongs_to :genre
  has_and_belongs_to_many :product_groups
  has_and_belongs_to_many :products

  def products
    product_arr = []
    self.product_groups.each do |pg|
      pg.products.each do |p|
        name = p.name ? p.name : "none"
        product_arr << pg.name + " : " + name + "-" + p.number
      end
    end

    product_arr

  end



end

