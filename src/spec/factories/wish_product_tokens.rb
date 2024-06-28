FactoryBot.define do
  factory :wish_product_token do
    token { WishProductToken.generate_token }
    customer
  end
end
