class CreatesProductConfigurationsProducts < ActiveRecord::Migration
  def change
    create_table :product_configurations_products do |t|
      t.references product_configuration
      t.references product
    end
  end
end
