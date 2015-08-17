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

  def lever_design_name
   lever_design ? lever_design.name : nil
  end 

  def color_name
   color ? color.name : nil
  end 

  def material_name
   material ? material.name : nil
  end 

  def basin_design_name
   basin_design ? basin_design.name : nil
  end 

  def console_counter_vanity_design_name
   console_counter_vanity_design ? console_counter_vanity_design.name : nil
  end 

  def door_trim_design_name
   door_trim_design ? door_trim_design.name : nil
  end 

  def wall_trim_design_name
   wall_trim_design ? wall_trim_design.name : nil
  end 

  def ceiling_lights_design_name
   ceiling_lights_design ? ceiling_lights_design.name : nil
  end 

  def wall_lights_design_name
   wall_lights_design ? wall_lights_design.name : nil
  end 

  def wallpaper_design_name
   wall_paper_design ? wall_paper_design.name : nil
  end 
end
