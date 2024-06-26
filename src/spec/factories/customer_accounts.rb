FactoryBot.define do
  factory :customer_account do
    sequence(:email) { |n| "customer#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    user_name { 'testuser' }

    customer factory: %i[customer]
  end
end
