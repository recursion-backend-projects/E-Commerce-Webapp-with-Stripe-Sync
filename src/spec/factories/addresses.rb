FactoryBot.define do
    factory :address do
      zip_code { "12345" }
      state { "TestState" }
      city { "TestCity" }
      street_address { "TestStreet" }
      street_address_2 { "TestStreet2" }
      association :addressable, factory: :customer_account
    end
  end
  