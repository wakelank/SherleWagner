class AddProductGroupToFinishesProductGroups < ActiveRecord::Migration
  def change
    add_reference :finishes_product_groups, :product_group, index: true, foreign_key: true
  end
end
