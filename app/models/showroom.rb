class Showroom < ActiveRecord::Base
  rails_admin do
    edit do
      field :header
      field :name
      configure :address do
        partial 'showroom_address'
      end
      field :address
      field :phone
      field :fax
      field :website
      field :emails, :pg_string_array
      field :region
    end
  end

  def self.regions
    Showroom.pluck(:region).uniq
  end

  def self.from region:
    Showroom.where(region: region)
  end
end
