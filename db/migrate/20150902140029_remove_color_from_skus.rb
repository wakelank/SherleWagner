class RemoveColorFromSkus < ActiveRecord::Migration
  def change
    remove_reference :skus, :color, index: true, foreign_key: true
  end
end
