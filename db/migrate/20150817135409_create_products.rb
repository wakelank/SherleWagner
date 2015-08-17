class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :number
      t.text :long_description

      t.timestamps null: false
    end
  end
end
