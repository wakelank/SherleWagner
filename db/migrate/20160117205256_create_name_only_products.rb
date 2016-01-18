class CreateNameOnlyProducts < ActiveRecord::Migration
  def change
    create_table :name_only_products do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
