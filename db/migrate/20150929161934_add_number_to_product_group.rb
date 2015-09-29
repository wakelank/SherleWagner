class AddNumberToProductGroup < ActiveRecord::Migration
  def change
    add_column :product_groups, :number, :string
  end
end
