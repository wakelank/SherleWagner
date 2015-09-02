class DropColorsTable < ActiveRecord::Migration
  def change
    drop_table :colors
  end
end
