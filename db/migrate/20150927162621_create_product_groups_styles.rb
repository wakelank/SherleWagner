class CreateProductGroupsStyles < ActiveRecord::Migration
  def change
    create_table :product_groups_styles do |t|
      t.references :product_group, index:true, foreign_key: true
      t.references :style, index: true, foreign_key: true
    end
  end
end
