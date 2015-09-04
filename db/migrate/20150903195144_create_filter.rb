class CreateFilter < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.references :product, index: true, foreign_key: true
    end
  end
end
