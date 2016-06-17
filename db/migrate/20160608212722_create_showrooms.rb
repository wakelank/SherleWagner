class CreateShowrooms < ActiveRecord::Migration
  def change
    create_table :showrooms do |t|
      t.string :header
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax
      t.string :website
      t.string :emails, array: true
      t.string :region

      t.timestamps null: false
    end
  end
end
