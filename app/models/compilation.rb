class Compilation < ActiveRecord::Base
  has_and_belongs_to_many :products


  def self.upload_compilations_from_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ',', headers: true) do |row|
      args = {}
      args[:name] = self.get_name_from row
      args[:number] = self.get_generic_number_from row
      if args[:number] == "TITLE-XX"
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
end

