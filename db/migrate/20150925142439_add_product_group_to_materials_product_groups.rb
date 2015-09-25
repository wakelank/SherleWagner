class AddProductGroupToMaterialsProductGroups < ActiveRecord::Migration
  def change
    add_reference :materials_product_groups, :product_group, index: true, foreign_key: true
  end
end
