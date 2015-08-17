class CreateConsoleCounterVanityDesigns < ActiveRecord::Migration
  def change
    create_table :console_counter_vanity_designs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
