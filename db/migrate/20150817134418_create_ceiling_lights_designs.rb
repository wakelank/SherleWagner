class CreateCeilingLightsDesigns < ActiveRecord::Migration
  def change
    create_table :ceiling_lights_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
