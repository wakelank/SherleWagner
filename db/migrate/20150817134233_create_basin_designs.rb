class CreateBasinDesigns < ActiveRecord::Migration
  def change
    create_table :basin_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
