class AddProductGroupToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :product_group, index: true, foreign_key: true
  end
end
