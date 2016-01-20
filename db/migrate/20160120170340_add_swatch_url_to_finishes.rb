class AddSwatchUrlToFinishes < ActiveRecord::Migration
  def change
    add_column :finishes, :image_url, :string
  end
end
