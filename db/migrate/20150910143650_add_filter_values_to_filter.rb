class AddFilterValuesToFilter < ActiveRecord::Migration
  def change
    add_reference :filters, :filter_value, index: true, foreign_key: true
  end
end
