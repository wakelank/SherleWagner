class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
