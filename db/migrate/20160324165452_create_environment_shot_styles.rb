class CreateEnvironmentShotStyles < ActiveRecord::Migration
  def change
    create_table :environment_shot_styles do |t|
      t.references :environment_shot, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true
    end
  end
end
