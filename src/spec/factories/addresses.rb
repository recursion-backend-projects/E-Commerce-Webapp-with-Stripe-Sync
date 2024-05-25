FactoryBot.define do
  factory :address do
    zip_code { "1234567" }
    state { "Tokyo" }
    city { "Chiyoda" }
    street_address { "1-1-1" }
    street_address_2 { "Building 101" }
    addressable { association :customer }
  end
end
