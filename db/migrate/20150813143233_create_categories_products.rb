class CreateCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
