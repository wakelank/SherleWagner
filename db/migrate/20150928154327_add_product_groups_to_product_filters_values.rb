class AddProductGroupsToProductFiltersValues < ActiveRecord::Migration
  def change
    add_reference :filter_product_values, :product_group, index: true, foreign_key: true
  end
end
