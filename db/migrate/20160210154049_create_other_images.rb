class CreateOtherImages < ActiveRecord::Migration
  def change
    create_table :other_images do |t|
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
