class ChangeMaterialsProductsToMaterialsProductGroups < ActiveRecord::Migration
  def change
    rename_table :materials_products, :materials_product_groups
  end
end
