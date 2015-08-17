class CreateDoorTrimDesigns < ActiveRecord::Migration
  def change
    create_table :door_trim_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
