class CreateProductConfiguration < ActiveRecord::Migration
  def change
    create_table :product_configurations do |t|
      t.references :product, index: true, foreign_key: true
      t.string :number
    end
  end
end
