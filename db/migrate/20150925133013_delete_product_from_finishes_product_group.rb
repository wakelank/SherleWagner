class DeleteProductFromFinishesProductGroup < ActiveRecord::Migration
  def change
    remove_column :finishes_product_groups, :product_id, :integer
  end
end
