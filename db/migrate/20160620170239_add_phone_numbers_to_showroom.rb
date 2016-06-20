class AddPhoneNumbersToShowroom < ActiveRecord::Migration
  def change
    add_column :showrooms, :phone_numbers, :string, array: true, default: []
  end
end
