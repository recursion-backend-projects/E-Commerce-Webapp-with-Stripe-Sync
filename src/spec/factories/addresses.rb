FactoryBot.define do
  factory :address do
    addressable { association :customer }
  end
end
