class AddDescriptionToProductConfiguration < ActiveRecord::Migration
  def change
    add_column :product_configurations, :description, :string
  end
end
