class AddDefaultToProductConfiguration < ActiveRecord::Migration

  def change
    add_column :product_configurations, :default, :boolean
  end
end
