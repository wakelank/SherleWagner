class CreateCompilations < ActiveRecord::Migration
  def change
    create_table :compilations do |t|
      t.string :name
      t.string :number
    end
  end
end
