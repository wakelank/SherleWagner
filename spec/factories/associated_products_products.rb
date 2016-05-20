# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :associated_products_product do
    product nil
    associated_product nil
  end
end
