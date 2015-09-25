class AddProductTypeToProductGroups < ActiveRecord::Migration
  def change
    add_reference :product_groups, :product_type, index: true, foreign_key: true
  end
end
