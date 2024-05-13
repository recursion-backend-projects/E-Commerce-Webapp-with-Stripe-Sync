FactoryBot.define do
  factory :customer_account do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
