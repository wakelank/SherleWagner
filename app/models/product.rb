require 'csv'
class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :sub_categories

  def self.load_file(filename)
    CSV.foreach(filename.path, col_sep: ",", encoding: "MacRoman", headers: true) do |line|
      if line['PRODUCT CODE'] != ''
        product = Product.new
        category = Category.where(name: line['CATEGORY'])
        sub_category = SubCategory.where(name: line['SUB CATEGORY'])
        name = line['PRODUCT'] || ""
        number = line['PRODUCT CODE'] || ""

        product.categories << category
        product.sub_categories << sub_category
        product.name = name
        product.number = number

        begin
          product.save
        rescue
          logger.debug "Did not load: #{category}, #{sub_category}, #{name}, #{number}.\n"
        end
      end
    end
  end

end
