class CreateProductsSubCategories < ActiveRecord::Migration
  def change
    create_table :products_sub_categories do |t|
      t.references :product, index: true, foreign_key: true
      t.references :sub_category, index: true, foreign_key: true
    end
  end
end
