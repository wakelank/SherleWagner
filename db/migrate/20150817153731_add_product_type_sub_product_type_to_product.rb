class AddProductTypeSubProductTypeToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :product_type, index: true, foreign_key: true
    add_reference :products, :product_sub_type, index: true, foreign_key: true
  end
end
