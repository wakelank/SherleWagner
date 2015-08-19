class AddGenreStyleToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :genre, index: true, foreign_key: true
    add_reference :products, :style, index: true, foreign_key: true
  end
end
