class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :name
      t.references :product, index: true, foreign_key: true
      t.references :material, index: true, foreign_key: true
      t.references :color, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true
      t.references :product_type, index: true, foreign_key: true
      t.references :product_sub_type, index: true, foreign_key: true
      t.references :basin_design, index: true, foreign_key: true
      t.references :ceiling_lights_design, index: true, foreign_key: true
      t.references :console_counter_vanity_design, index: true, foreign_key: true
      t.references :door_trim_design, index: true, foreign_key: true
      t.references :lever_design, index: true, foreign_key: true
      t.references :overall_color, index: true, foreign_key: true
      t.references :wall_lights_design, index: true, foreign_key: true
      t.references :wall_paper_design, index: true, foreign_key: true
      t.references :wall_trim_design, index: true, foreign_key: true
      t.references :water_closet_handle_design, index: true, foreign_key: true
    end
  end
end
