class AddAttachmentImageToProductSubTypes < ActiveRecord::Migration
  def self.up
    change_table :product_sub_types do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :product_sub_types, :image
  end
end
