class CreateProductGroupFilters < ActiveRecord::Migration
  def change
    create_table :product_group_filters do |t|
      t.references :product_group, index: true, foreign_key: true
      t.references :filter, index: true, foreign_key: true
    end
  end
end
