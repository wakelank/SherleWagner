class CreateCompilationRelationships < ActiveRecord::Migration
  def change
    create_table :compilation_relationships do |t|
      t.belongs_to :component, index: true, foreign_key: false
      t.belongs_to :compilation, index: true, foreign_key: false

      t.timestamps null: false
    end
  end
end
