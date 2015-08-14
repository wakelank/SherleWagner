class CreateProductSubTypes < ActiveRecord::Migration
  def change
    create_table :product_sub_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
