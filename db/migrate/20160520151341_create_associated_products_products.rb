class CreateAssociatedProductsProducts < ActiveRecord::Migration
  def change
    create_table :associated_products_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :associated_product, index: true

      t.timestamps null: false
    end
  end
end
