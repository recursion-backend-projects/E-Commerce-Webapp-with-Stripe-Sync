FactoryBot.define do
  factory :customer do
    after(:build) do |customer|
      customer.build_address(
        zip_code: "1234567",
        state: "Tokyo",
        city: "Chiyoda",
        street_address: "1-1-1",
        street_address_2: "Building 101"
      )
    end
  end
end
