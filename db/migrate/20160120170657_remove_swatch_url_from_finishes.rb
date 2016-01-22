class RemoveSwatchUrlFromFinishes < ActiveRecord::Migration
  def change
    remove_column :finishes, :image_url, :string
  end
end
