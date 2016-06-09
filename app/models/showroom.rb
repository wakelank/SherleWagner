class Showroom < ActiveRecord::Base
  rails_admin do
    edit do
      field :header
    end

    edit do
      field :name
    end

    edit do
      field :address
    end

    edit do
      field :phone
    end

    edit do
      field :fax
    end

    edit do
      field :website
    end

    edit do
      field :emails, :pg_string_array
    end

    edit do
      field :region
    end

  end
end
