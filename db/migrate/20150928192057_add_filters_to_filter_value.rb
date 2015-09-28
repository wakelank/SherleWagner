class AddFiltersToFilterValue < ActiveRecord::Migration
  def change
    add_reference :filter_values, :filter, index: true, foreign_key: true
  end
end
