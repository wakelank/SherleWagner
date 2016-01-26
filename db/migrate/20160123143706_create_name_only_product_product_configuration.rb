class CreateNameOnlyProductProductConfiguration < ActiveRecord::Migration
  def change
    create_table :name_only_prod_prod_configs do |t|
      t.references :name_only_product, index: true, foreign_key: true
      t.references :product_configuration, index: true, foreign_key: true
    end
  end
end
