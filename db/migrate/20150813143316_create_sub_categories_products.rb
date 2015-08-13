class CreateSubCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :sub_categories_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :sub_category, index: true, foreign_key: true
    end
  end
end
