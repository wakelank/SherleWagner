class AddDisplayCodeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :display_code, :string
  end
end
