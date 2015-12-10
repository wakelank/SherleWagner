class ProductConfiguration < ActiveRecord::Base

  belongs_to :product
  validates :number, presence: true, uniqueness: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_configuration.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

  def self.get_arg(row)
    args = {}
    args[:number] = row["IMAGE FILE"] || NullObject.new() 
    image_name = self.get_image_name_from row
        #images_path = "/Users/ph1am/Desktop/SW website/images1"
        images_path = "/Users/wake/Documents/Work/SherleWagner/images"
        image_file = NullObject.new
        Find.find(images_path) do |filepath|
          if File.basename(filepath) == image_name
            image_file = File.new(filepath) || NullObject.new
          end
        end
        args[:image] = image_file if !image_file.nil?

    product_configuration = ProductConfiguration.new(args) || NullObject.new
    if product_configuration.valid?
      product_configuration
    else
      NullObject.new
    end

  end

  def self.get_image_name_from(row)
    name = row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
  end


end

