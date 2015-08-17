class AddTypeToSubType < ActiveRecord::Migration
  def change
    add_reference :product_sub_types, :product_type, index: true, foreign_key: true
  end
end
