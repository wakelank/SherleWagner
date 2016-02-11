class AddAttachmentImageToOtherImages < ActiveRecord::Migration
  def self.up
    change_table :other_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :other_images, :image
  end
end
