class Sku < ActiveRecord::Base
  belongs_to :product
  belongs_to :material
  belongs_to :color
  belongs_to :genre
  belongs_to :style
  belongs_to :product_type
  belongs_to :product_sub_type
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
end
