class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
