class CreateWallTrimDesigns < ActiveRecord::Migration
  def change
    create_table :wall_trim_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
