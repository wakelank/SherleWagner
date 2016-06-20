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
      field :phone
      field :fax
      field :mobile
      field :website
      field :emails, :pg_string_array
      field :region
    end
  end

  def self.regions
    Showroom.pluck(:region).uniq
  end

  # def self.regional_offices
  #   Showroom.where(regional_office: true).ord
  # end

#   def self.from region:
#     Showroom.where(region: region)
#   end
end
