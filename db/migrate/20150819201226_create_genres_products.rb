class CreateGenresProducts < ActiveRecord::Migration
  def change
    create_table :genres_products do |t|
      t.references :genre, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
