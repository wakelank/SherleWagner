class CreateChinaColors < ActiveRecord::Migration
  def change
    create_table :china_colors do |t|
      t.string :name
      t.string :identifier

      t.timestamps null: false
    end
  end
end
