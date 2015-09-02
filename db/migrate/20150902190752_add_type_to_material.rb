class AddTypeToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :type, :string
  end
end
