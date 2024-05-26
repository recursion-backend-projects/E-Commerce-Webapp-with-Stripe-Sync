FactoryBot.define do
  factory :customer_account do
    email { 'test@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
    user_name { 'testuser' }
  end
end
