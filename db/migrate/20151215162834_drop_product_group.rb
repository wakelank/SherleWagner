class DropProductGroup < ActiveRecord::Migration
  def change
    remove_column :products, :product_group_id
    remove_column :filter_product_values, :product_group_id
    drop_table :china_colors_product_groups
    drop_table :filter_product_group_values
    drop_table :filter_values_product_groups
    drop_table :finishes_product_groups
    drop_table :genres_product_groups
    drop_table :materials_product_groups
    drop_table :product_group_filters
    drop_table :product_groups_styles
    drop_table :product_groups
  end
end
