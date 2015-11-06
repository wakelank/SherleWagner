class CreateChinaColorsProductGroups < ActiveRecord::Migration
  def change
    create_table :china_colors_product_groups do |t|
      t.references :china_color, index: true, foreign_key: true
      t.references :product_group, index: true, foreign_key: true
    end
  end
end
