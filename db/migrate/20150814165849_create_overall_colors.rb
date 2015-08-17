class CreateOverallColors < ActiveRecord::Migration
  def change
    create_table :overall_colors do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
