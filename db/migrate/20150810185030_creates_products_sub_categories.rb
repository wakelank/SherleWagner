class CreatesProductsSubCategories < ActiveRecord::Migration
  def change
    create_table :products_sub_categories, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :sub_category, index: true
    end
  end
end
