class AddIdentifierToFinish < ActiveRecord::Migration
  def change
    add_column :finishes, :identifier, :string
  end
end
