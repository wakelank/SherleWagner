class AddDisplaySizeForCollectionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :display_size_for_collection, :string, default: "small"
  end
end
