FactoryBot.define do
  factory :order do
    order_number { "MyString" }
    total { 1 }
    order_date { "2024-05-27 17:19:52" }
    guest_email { "MyString" }
    customer { nil }
  end
end
