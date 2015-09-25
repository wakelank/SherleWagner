class RemoveProductFromMaterialsProductGroups < ActiveRecord::Migration
  def change
    remove_column :materials_product_groups, :product_id, :integer
  end
end
