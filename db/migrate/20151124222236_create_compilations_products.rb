class CreateCompilationsProducts < ActiveRecord::Migration
  def change
    create_table :compilations_products do |t|
      t.references :compilation, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
