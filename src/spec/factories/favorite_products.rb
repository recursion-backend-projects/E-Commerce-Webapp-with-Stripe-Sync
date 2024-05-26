# spec/factories/favorite_products.rb
FactoryBot.define do
  factory :favorite_product do
    customer
    product
  end
end
