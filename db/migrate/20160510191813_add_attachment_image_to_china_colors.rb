class AddAttachmentImageToChinaColors < ActiveRecord::Migration
  def self.up
    change_table :china_colors do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :china_colors, :image
  end
end
