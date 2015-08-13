class DropProductSubCategories < ActiveRecord::Migration
  def change
    drop_table :products_sub_categories
  end
end
