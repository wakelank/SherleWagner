class CreateProductsStyles < ActiveRecord::Migration
  def change
    create_table :products_styles do |t|
      t.references :product, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true
    end
  end
end
