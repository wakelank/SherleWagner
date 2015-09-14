class CreateFilterProductValue < ActiveRecord::Migration
  def change
    create_table :filter_product_values do |t|
      t.references :product, index: true, foreign_key: true
      t.references :filter, index: true, foreign_key: true
      t.references :filter_value, index: true, foreign_key: true
    end
  end
end
