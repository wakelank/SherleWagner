class ProductConfiguration < ActiveRecord::Base

  belongs_to :product
  validates :number, presence: true, uniqueness: true

  def self.get_arg(row)
    number = row["IMAGE FILE"] || NullObject.new() 
    product_configuration = ProductConfiguration.new(number: number) || NullObject.new
    if product_configuration.valid?
      product_configuration
    else
      NullObject.new
    end

  end

end

