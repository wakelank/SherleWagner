require 'english'
require 'csv'

class Product < ActiveRecord::Base
 # belongs_to :basin_design
 # belongs_to :ceiling_lights_design
 # belongs_to :console_counter_vanity_design
 # belongs_to :door_trim_design
 # belongs_to :lever_design
 # belongs_to :overall_color
 # belongs_to :wall_lights_design
 # belongs_to :wall_paper_design
 # belongs_to :wall_trim_design
 # belongs_to :water_closet_handle_design
 # belongs_to :product_type
 # belongs_to :product_sub_type  
 # belongs_to :product_group

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: 'image/jpeg' }

  def self.new_upload_product_file(file)
    CSV.foreach(file.path, encoding: "MacRoman", col_sep: ';', headers: true) do |row|
      name = row["GENERIC PRODUCT NAME _ Revised"]
      generic_product_number = row["Generic Product Number"]
      product_number = row["IMAGE FILE"]
      product_type = row['MAIN']
      product_sub_type = row['SUB FOLDER']
      if !Product.exists?(number: product_number) && product_number != nil
        begin
          product_type =ProductType.where(name: product_type).first_or_create
          product_sub_type = ProductSubType.where(name: product_sub_type).first_or_create
          if !generic_product_number.nil? && generic_product_number != ""
            product_group_args = { number: generic_product_number, 
                                   name: name, 
                                   product_type: product_type, 
                                   product_sub_type: product_sub_type }
            product_group = ProductGroup.first_or_custom_create(product_group_args)
          end
          product = Product.create(name: name, 
                                   number: product_number, 
                                   product_group: product_group)
        rescue
          binding.pry
        end

        begin
          if !product_group.nil? && product_group.name != "TITLE-XX"
            style_name = row["STYLES"]
#            if !style_name.nil? && style_name != ""
            if !style_name.blank?
              style = Style.where('lower(name) = ?', style_name.downcase.strip).first
              product_group.styles << style
            end
            filter_name = row["FILTERS"]
           # if !filter_name.nil? && filter_name !=""
            if !filter_name.blank?
              filter_value = FilterValue.where('lower(name) = ?', filter_name.downcase.strip).first
              product_group.filter_values << filter_value if !filter_value.nil?
            end
            filter_name = row["FILTERS2"]
            if !filter_name.nil? && filter_name !=""
              filter_value = FilterValue.where('lower(name) = ?', filter_name.downcase.strip).first
              product_group.filter_values << filter_value if !filter_value.nil?
            end
            product_group.save
          end

        rescue
          binding.pry
        end
      end
    end
  end
end

