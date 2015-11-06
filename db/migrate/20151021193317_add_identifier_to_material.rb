class AddIdentifierToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :identifier, :string
  end
end
