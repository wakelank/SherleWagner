class AddIsInsertToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :is_insert, :boolean
  end
end
