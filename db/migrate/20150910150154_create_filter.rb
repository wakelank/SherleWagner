class CreateFilter < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
    end
  end
end
