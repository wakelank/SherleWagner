class Product < ActiveRecord::Base
  has_many :skus 
  has_many :materials, through: :skus
  has_many :colors, through: :skus
  has_many :genres, through: :skus
  has_many :styles, through: :skus
  has_many :product_types, through: :skus
  has_many :product_sub_types, through: :skus
  has_many :basin_designs, through: :skus
  has_many :ceiling_lights_designs, through: :skus
  has_many :console_counter_vanity_designs, through: :skus
  has_many :door_trim_designs, through: :skus
  has_many :lever_designs, through: :skus
  has_many :overall_colors, through: :skus
  has_many :wall_lights_designs, through: :skus
  has_many :wall_paper_designs, through: :skus
  has_many :wall_trim_designs, through: :skus
  has_many :water_closet_handle_designs, through: :skus

  belongs_to :product_type
  belongs_to :product_sub_type  
end

