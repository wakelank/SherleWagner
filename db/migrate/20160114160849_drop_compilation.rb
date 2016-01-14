class DropCompilation < ActiveRecord::Migration
  def change
    drop_table :associated_compilations
  end
end
