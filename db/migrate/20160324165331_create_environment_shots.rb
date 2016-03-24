class CreateEnvironmentShots < ActiveRecord::Migration
  def change
    create_table :environment_shots do |t|

      t.timestamps null: false
    end
  end
end
