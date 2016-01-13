class CreateProductComponents < ActiveRecord::Migration
  def change
    create_table :product_components, :id => false do |t|
      t.integer "product_a_id", :null => false
      t.integer "product_b_id", :null => false
    end
  end
end
