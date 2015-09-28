class CreateFilterValuesProductGroups < ActiveRecord::Migration
  def change
    create_table :filter_values_product_groups do |t|
      t.references :filter_value, index: true, foreign_key: true
      t.references :product_group, index: true, foreign_key: true
    end
  end
end
