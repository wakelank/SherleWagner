class AddOrderingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :page_section, :string
    add_column :products, :section_position, :integer
  end
end
