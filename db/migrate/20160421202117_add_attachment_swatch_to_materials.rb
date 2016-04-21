class AddAttachmentSwatchToMaterials < ActiveRecord::Migration
  def self.up
    change_table :materials do |t|
      t.attachment :swatch
    end
  end

  def self.down
    remove_attachment :materials, :swatch
  end
end
