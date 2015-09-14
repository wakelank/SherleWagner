class CreateFilterValue < ActiveRecord::Migration
  def change
    create_table :filter_values do |t|
      t.string :name
    end
  end
end
