class AddModernSwatchUrlToFinishes < ActiveRecord::Migration
  def change
    add_column :finishes, :modern_swatch_url, :string
  end
end
