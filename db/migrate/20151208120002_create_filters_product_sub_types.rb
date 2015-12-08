class CreateFiltersProductSubTypes < ActiveRecord::Migration
  def change
    create_table :filters_product_sub_types do |t|
      t.references :filter, index: true, foreign_key: true
      t.references :product_sub_type, index: true, foreign_key: true
    end
  end
end
