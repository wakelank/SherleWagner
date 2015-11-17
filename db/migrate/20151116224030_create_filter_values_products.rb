class CreateFilterValuesProducts < ActiveRecord::Migration
  def change
    create_table :filter_values_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :filter_value, index: true, foreign_key: true
    end
  end
end
