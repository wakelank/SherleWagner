class DropFilterValues < ActiveRecord::Migration

  def change
    drop_table :filter_values
  end
end
