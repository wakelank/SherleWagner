class AddAttachmentImageToProductConfigurations < ActiveRecord::Migration
  def self.up
    change_table :product_configurations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :product_configurations, :image
  end
end
