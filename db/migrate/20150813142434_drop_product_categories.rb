class DropProductCategories < ActiveRecord::Migration
  def change
    drop_table :products_categories
  end
end
