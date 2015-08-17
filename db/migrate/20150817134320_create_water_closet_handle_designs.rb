class CreateWaterClosetHandleDesigns < ActiveRecord::Migration
  def change
    create_table :water_closet_handle_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
