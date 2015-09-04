class FilterValues < ActiveRecord::Migration
  def change
    create_table :filter_values do |t|
      t.references :product, index: true
      t.string :name
    end
  end
end
