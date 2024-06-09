FactoryBot.define do
  factory :product do
    name { 'apple' }
    price { 150 }
    stock { 100 }
    description { '美味しいりんご' }
    creator { 'ニュートン' }
    product_category
  end
end
