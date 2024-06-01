FactoryBot.define do
  factory :product_review do
    title { Faker::Lorem.characters(number: 50) }
    review { Faker::Lorem.paragraph_by_chars(number: 400, supplemental: false) }
    rating { Faker::Number.between(from: 1, to: 5) }
    customer
    product
  end
end
