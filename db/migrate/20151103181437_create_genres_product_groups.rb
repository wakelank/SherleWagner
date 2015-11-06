class CreateGenresProductGroups < ActiveRecord::Migration
  def change
    create_table :genres_product_groups do |t|
      t.references :genre, index: true, foreign_key: true
      t.references :product_group, index: true, foreign_key: true
    end
  end
end
