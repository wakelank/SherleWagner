class AddMaterialsToColors < ActiveRecord::Migration
  def change
    add_reference :colors, :material, index: true, foreign_key: true
  end
end
