class AddAttachmentImageToStyles < ActiveRecord::Migration
  def self.up
    change_table :styles do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :styles, :image
  end
end
