class ChangeFinishesProductsToFinishesProductGroups < ActiveRecord::Migration
  def change
    rename_table :finishes_products, :finishes_product_groups
  end
end
