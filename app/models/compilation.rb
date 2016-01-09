class Compilation < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_compliation.jpg"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }
  has_and_belongs_to_many(:compilations,
                          :join_table => "associated_compilations",
                          :foreign_key => "compilation_a_id",
                          :association_foreign_key => "compilation_b_id")
  extend ImageFilePath

  def self.upload_compilations_from_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      args = {}
      args[:name] = self.get_name_from row
      args[:number] = self.get_generic_number_from row
      if args[:number] == "TITLE-XX"
        image_name = self.get_image_name_from row
     #   images_path = "/Users/ph1am/Desktop/SW website/images1"
#        images_path = "/Users/wake/Documents/Work/SherleWagner/images"
         images_path = self.image_file_path
        image_file = NullObject.new
        Find.find(images_path) do |filepath|
          if File.basename(filepath) == image_name
            image_file = File.new(filepath) || NullObject.new
          end
        end
        args[:image] = image_file if !image_file.nil?

        compilation = Compilation.new(args)
        compilation.save if compilation.valid?
      else
        product_code = row["CODE under Product Name"] || "no name"
        image_name  = row["IMAGE FILE"] || "no name"
        if image_name == "no name"
          product = Product.where('number like ?', "#{product_code}%") || NullObject.new
          compilation = Compilation.last || NullObject.new
          compilation.products << product if !product.nil?
          compilation.save
        end
      end

    end
  end

  def self.get_name_from(row)
    row["GENERIC PRODUCT NAME _ Revised"] || "no name"
  end

  def self.get_generic_number_from(row)
    row["Generic Product Number"] || "no product number"
  end

  def self.get_image_name_from(row)
    name = row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
  end

end

