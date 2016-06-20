class AddMobileToShowroom < ActiveRecord::Migration
  def change
    add_column :showrooms, :mobile, :string
  end
end
