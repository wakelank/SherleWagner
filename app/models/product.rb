require 'english'
require 'csv'

class Product < ActiveRecord::Base
  has_and_belongs_to_many :finishes, class_name: 'Finish', join_table: :finishes_products
  has_and_belongs_to_many :accents, class_name: 'Finish', join_table: :accents_products
  has_and_belongs_to_many :inserts, class_name: 'Material', join_table: :inserts_products
  has_and_belongs_to_many :materials, class_name: 'Material', join_table: :materials_products
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :styles
  has_and_belongs_to_many :product_types
  has_and_belongs_to_many :product_sub_types
  has_many :filter_values
  has_many :filters, through: :filter_values
  belongs_to :basin_design
  belongs_to :ceiling_lights_design
  belongs_to :console_counter_vanity_design
  belongs_to :door_trim_design
  belongs_to :lever_design
  belongs_to :overall_color
  belongs_to :wall_lights_design
  belongs_to :wall_paper_design
  belongs_to :wall_trim_design
  belongs_to :water_closet_handle_design

  belongs_to :product_type
  belongs_to :product_sub_type  

  belongs_to :product_group

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

  def self.upload_product_file(file)
    CSV.foreach(file.path, col_sep: ";", encoding: "MacRoman", headers: true) do |row|
      if $INPUT_LINE_NUMBER >= 5
        $INPUT_LINE_NUMBER ? line_num = $INPUT_LINE_NUMBER : line_num = 0
        name = row["PRODUCT NAME-Revised"]
        long_description = row["PRODUCT DESCRIPTION"]
        number = row["CODE under Product Name"]
        product = Product.create(name: name, long_description: long_description, number: number)
        if ProductGroup.where(name: name).first
          product_group = ProductGroup.where(name: name).first
        else
          product_group = ProductGroup.create(name: name)
        end
        product.product_group = product_group
        begin
          image_url = "http://s3.amazonaws.com/sherle-wagner/temp/#{row['IMAGE FILE']}.jpg"
          product.image = URI.parse(image_url)
        rescue
        end
        row.each do |header, value|
          if value && value.downcase.strip == 'x'
            if header
              headerArr = header.split('-')
              if headerArr[0] == "Materials"
                material_type = headerArr[1].downcase.strip
                material_name = headerArr[2].downcase.strip
                case material_type
                  when 'metal'
                    begin
                      finish = Finish.where('lower(name) = ?', material_name).first
                      product.finishes << finish
                    rescue
                      binding.pry
                    end
                  when 'china'
                    begin
                      china_type = "China-" + headerArr[2].titleize.strip
                      materials = Material.where(material_type: china_type)
                      materials.each do |material|
                        if product.has_finish? 
                          product.inserts << material
                        else
                          product.materials << material
                        end
                      end
                    rescue
                      binding.pry
                    end

                  when 'marble'
                    begin
                      material = Material.where('lower(name) = ?', material_name).first
                      product.materials << material
                    rescue
                      binding.pry
                    end
                  when 'onyx' || 'semi precious stones'
                    begin
                      material = Material.where('lower(name) = ?', material_name).first
                      if product.has_finish?
                        product.inserts << material
                      else
                        product.materials << material
                      end
                    rescue
                      binding.pry
                    end
                  when 'semi precious stones'
                     begin
                      material = Material.where('lower(name) = ?', material_name).first
                      if product.has_finish?
                        product.inserts << material
                      else
                        product.materials << material
                      end
                    rescue
                      binding.pry
                    end


                end


               # material = Material.where('lower(name) = ?',headerArr[1].downcase.strip).first
               # color = Color.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                #  product.colors << color
                #  product.materials << material
                rescue
                end

              elsif headerArr[0] == "COLLECTIONS"
                genre = Genre.where('lower(name) = ?', headerArr[1].downcase.strip).first
                style = Style.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                  product.genres << genre
                  product.styles << style
                rescue
                  binding.pry
                end
                product.save
              elsif headerArr[0] == "PRODUCTS"
                product_type = ProductType.where('lower(name) = ?', headerArr[1].downcase.strip).first
                product_sub_type = ProductSubType.where('lower(name) = ?', headerArr[2].downcase.strip).first
                begin
                  product.product_type = product_type
                  product.product_sub_type = product_sub_type
                  product.save
                rescue
                  binding.pry
                end
              elsif headerArr[0] == "FILTERS"
                begin
                  filter = Filter.where('lower(name) = ?', headerArr[1].downcase.strip).first
                  val = headerArr[2]
                  FilterValue.create(name: val, product: product, filter: filter)
                rescue
                  binding.pry
                end
              end
            end
          end
        end
      end
    end
  end

def has_finish?
  return true if self.finishes.length > 0
  return false
end

def insert_types
  return self.inserts.pluck(:material_type).uniq
end

def inserts_of_type(insert_type)
  return self.inserts.where(material_type: insert_type)
end

def material_types
  return self.materials.pluck(:material_type).uniq
end

def materials_of_type(material_type)
  return self.materials.where(material_type: material_type)
end


end

