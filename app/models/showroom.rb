class Showroom < ActiveRecord::Base
  rails_admin do
    edit do
      field :order
      field :regional_office
      field :regional_office_label
      field :header
      field :name
      configure :address do
        partial 'showroom_address'
      end
      field :address
      field :phone_numbers, :pg_string_array do
        label 'phone numbers (comma separated)'
      end
      field :fax
      field :mobile
      field :website
      field :emails, :pg_string_array do
        label 'Emails (comma separated)'
      end
      field :region
    end
  end

  def self.regions
    Showroom.pluck(:region).uniq
  end

end
