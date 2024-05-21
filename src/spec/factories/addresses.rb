FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    state { Faker::Address.state }
    city { Faker::Address.city }
    street_address { Faker::Address.street_address }
    street_address_2 { Faker::Address.secondary_address }
  end
end
