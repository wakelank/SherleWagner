class AddAttachmentImageToCompilations < ActiveRecord::Migration
  def self.up
    change_table :compilations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :compilations, :image
  end
end
