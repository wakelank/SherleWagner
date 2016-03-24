class AddAttachmentImageToEnvironmentShots < ActiveRecord::Migration
  def self.up
    change_table :environment_shots do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :environment_shots, :image
  end
end
