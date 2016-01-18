class AddProductReferenceToNameOnlyProduct < ActiveRecord::Migration
  def change
    add_reference :name_only_products, :product, index: true, foreign_key: true
  end
end
