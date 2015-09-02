class CreateAccentsProducts < ActiveRecord::Migration
  def change
    create_table :accents_products do |t|
      t.references :finish, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
