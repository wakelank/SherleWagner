class AddOrnateSwatchUrlToFinishes < ActiveRecord::Migration
  def change
    add_column :finishes, :ornate_swatch_url, :string
  end
end
