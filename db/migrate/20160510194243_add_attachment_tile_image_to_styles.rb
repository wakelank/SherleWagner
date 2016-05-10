class AddAttachmentTileImageToStyles < ActiveRecord::Migration
  def self.up
    change_table :styles do |t|
      t.attachment :tile_image
    end
  end

  def self.down
    remove_attachment :styles, :tile_image
  end
end
