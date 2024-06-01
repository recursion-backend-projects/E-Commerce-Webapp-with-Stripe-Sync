FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    order
    product
  end
end
