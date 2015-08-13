class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
    end
  end
end
