class CreateChinaColorsProducts < ActiveRecord::Migration
  def change
    create_table :china_colors_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :china_color, index: true, foreign_key: true
    end
  end
end
