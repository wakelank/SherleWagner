class AddImageTypeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :image_type, :string, default: "square"
  end
end
