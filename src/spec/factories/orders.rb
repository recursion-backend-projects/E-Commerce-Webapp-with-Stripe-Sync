FactoryBot.define do
  factory :order do
    order_number { '123-1234567-1234567' }
    total { 0 }
    order_date { Time.current }
    guest_email { 'test@gmail.com' }
    customer { nil }
    receipt_url { 'https://receipt.com' }

    trait :with_customer do
      guest_email { nil }
      customer
    end
  end

  factory :login_user_order, parent: :order do
    customer
  end
end
