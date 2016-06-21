class AddSubTitleToProductConfiguration < ActiveRecord::Migration
  def change
    add_column :product_configurations, :subtitle, :string
  end
end
