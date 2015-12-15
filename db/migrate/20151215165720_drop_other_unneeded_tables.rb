class DropOtherUnneededTables < ActiveRecord::Migration
  def change
    drop_table :skus
    drop_table :accents_products
    drop_table :basin_designs
    drop_table :ceiling_lights_designs
    drop_table :console_counter_vanity_designs
    drop_table :door_trim_designs
    drop_table :filter_product_values
    drop_table :inserts_products
    drop_table :lever_designs
    drop_table :overall_colors
    drop_table :wall_lights_designs
    drop_table :wall_paper_designs
    drop_table :wall_trim_designs
    drop_table :water_closet_handle_designs
  end
end
