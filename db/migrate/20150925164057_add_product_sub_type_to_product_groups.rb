class AddProductSubTypeToProductGroups < ActiveRecord::Migration
  def change
    add_reference :product_groups, :product_sub_type, index: true, foreign_key: true
  end
end
