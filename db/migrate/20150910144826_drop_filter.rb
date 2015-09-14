class DropFilter < ActiveRecord::Migration
  def change
    remove_column :filter_values, :filter_id
    remove_column :filters, :filter_value_id
    drop_table :filters
  end
end
