FactoryBot.define do
  factory :customer do
    stripe_customer_id { 'sample_stripe_customer_id' }
  end
end
