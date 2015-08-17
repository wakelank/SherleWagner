class AddIsCollectionToStyle < ActiveRecord::Migration
  def change
    add_column :styles, :is_collection, :boolean
  end
end
