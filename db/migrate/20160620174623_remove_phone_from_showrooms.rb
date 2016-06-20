class RemovePhoneFromShowrooms < ActiveRecord::Migration
  def change
    remove_column :showrooms, :phone, :string
  end
end
