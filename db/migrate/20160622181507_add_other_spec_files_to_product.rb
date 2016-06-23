class AddOtherSpecFilesToProduct < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :spec_sheet_3d
      t.attachment :spec_sheet_2d
    end
  end

  def self.down
    remove_attachment :products, :spec_sheet_3d
    remove_attachment :products, :spec_sheet_2d
  end
end
