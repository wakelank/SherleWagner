class RemoveImageAttributesFromChinaColor < ActiveRecord::Migration
  def change
    remove_column :china_colors, :image_file_name
    remove_column :china_colors, :image_content_type
    remove_column :china_colors, :image_file_size
    remove_column :china_colors, :image_updated_at
  end
end
