class CreateColorsProducts < ActiveRecord::Migration
  def change
    create_table :colors_products do |t|
      t.references :color, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
