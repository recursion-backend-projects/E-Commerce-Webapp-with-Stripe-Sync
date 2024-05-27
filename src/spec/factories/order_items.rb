FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    order { nil }
    product { nil }
  end
end
