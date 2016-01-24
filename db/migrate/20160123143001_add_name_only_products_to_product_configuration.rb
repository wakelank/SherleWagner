class AddNameOnlyProductsToProductConfiguration < ActiveRecord::Migration
  def change
    add_reference :product_configurations, :name_only_product, index: true, foreign_key: true
  end
end
