class ProductConfiguration < ActiveRecord::Base

  belongs_to :product
  validates :number, presence: true, uniqueness: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_configuration.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

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

