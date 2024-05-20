FactoryBot.define do
  factory :customer do
    association :customer_account
    association :address
  end
end
