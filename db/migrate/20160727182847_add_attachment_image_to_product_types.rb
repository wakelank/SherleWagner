class AddAttachmentImageToProductTypes < ActiveRecord::Migration
  def self.up
    change_table :product_types do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :product_types, :image
  end
end
