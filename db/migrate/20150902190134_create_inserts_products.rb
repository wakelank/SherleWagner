class CreateInsertsProducts < ActiveRecord::Migration
  def change
    create_table :inserts_products do |t|
      t.references :material, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
