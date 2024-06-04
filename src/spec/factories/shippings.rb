FactoryBot.define do
  factory :shipping do
    carrier { :sagawa }
    tracking_number { '12345678AZ' }
    status { 0 }
    shipping_at { '2024-06-01 10:55:01' }
    order
  end
end
