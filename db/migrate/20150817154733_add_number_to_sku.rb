class AddNumberToSku < ActiveRecord::Migration
  def change
    add_column :skus, :number, :string
  end
end
