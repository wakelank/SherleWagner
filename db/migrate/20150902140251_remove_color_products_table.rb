class RemoveColorProductsTable < ActiveRecord::Migration
  def change
    drop_table :colors_products
  end
end
