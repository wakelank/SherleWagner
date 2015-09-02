class DeleteTypeFromMaterial < ActiveRecord::Migration
  def change
    remove_column :materials, :type, :string
  end
end
