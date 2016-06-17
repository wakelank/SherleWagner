class AddOrderToShowrooms < ActiveRecord::Migration
  def change
    add_column :showrooms, :order, :integer
  end
end
