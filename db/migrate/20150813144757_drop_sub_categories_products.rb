class DropSubCategoriesProducts < ActiveRecord::Migration
  def change
    drop_table :sub_categories_products
  end
end
