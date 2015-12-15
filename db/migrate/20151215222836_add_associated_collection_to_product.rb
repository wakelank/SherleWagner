class AddAssociatedCollectionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :associated_collection_id, :integer, references: :styles
  end
end
