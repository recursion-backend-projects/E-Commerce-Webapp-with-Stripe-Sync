FactoryBot.define do
  factory :wish_product do
    association :customer
    association :product
  end
end

