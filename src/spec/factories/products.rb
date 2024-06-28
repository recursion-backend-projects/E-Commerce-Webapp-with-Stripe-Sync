FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "product_#{n}" }
    sequence(:price) { |n| n * 100 }
    stock { 100 }
    description { 'Test description' }
    creator { 'Test creator' }
    product_type { 'physics' }
    product_category

    trait :digital do
      product_type { 'digital' }
      after(:build) do |product|
        product.digital_file.attach(
          io: Rails.root.join('spec/fixtures/files/valid_digital_file.zip').open,
          filename: 'valid_digital_file.zip',
          content_type: 'application/zip'
        )
      end
    end
  end
end
