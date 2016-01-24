class NameOnlyProduct < ActiveRecord::Base
  has_and_belongs_to_many :product_configurations, :join_table => "name_only_prod_prod_configs"


  def compilations_number_string
    product_configuration.map { |conf| conf.number }.join(" ")
  end
end
