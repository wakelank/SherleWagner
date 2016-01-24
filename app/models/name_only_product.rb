class NameOnlyProduct < ActiveRecord::Base
  has_and_belongs_to_many :product_configuration, :join_table => "name_only_prod_prod_configs"
end
