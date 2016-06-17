class AddRegionalOfficeToShowroom < ActiveRecord::Migration
  def change
    add_column :showrooms, :regional_office, :boolean
    add_column :showrooms, :regional_office_label, :string
  end
end
