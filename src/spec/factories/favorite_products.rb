# spec/factories/favorite_products.rb
FactoryBot.define do
    factory :favorite_product do
      association :customer
      association :product
    end
  end
