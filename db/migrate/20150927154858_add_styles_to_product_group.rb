class AddStylesToProductGroup < ActiveRecord::Migration
  def change
    add_reference :product_groups, :style, index: true, foreign_key: true
  end
end
