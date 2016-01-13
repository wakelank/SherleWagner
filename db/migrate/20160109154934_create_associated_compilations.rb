class CreateAssociatedCompilations < ActiveRecord::Migration
  def change
    create_table :associated_compilations, :id => false do |t|
      t.integer "compilation_a_id", :null => false
      t.integer "compilation_b_id", :null => false
    end
  end
end
