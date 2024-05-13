FactoryBot.define do
  factory :product do
    name { 'apple' }
    price { '150' }
    stock { 100 }
    description { '美味しいりんご' }
    product_category_id { 1 }
  end
end
