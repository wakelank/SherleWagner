class CreateFilterProductGroupValues < ActiveRecord::Migration
  def change
    create_table :filter_product_group_values do |t|
      t.references :product_group, index: true, foreign_key: true
      t.references :filter, index: true, foreign_key: true
      t.references :filter_value, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
