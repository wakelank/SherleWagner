class AddAttachmentInstallationInstructionsToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :installation_instructions
    end
  end

  def self.down
    remove_attachment :products, :installation_instructions
  end
end
