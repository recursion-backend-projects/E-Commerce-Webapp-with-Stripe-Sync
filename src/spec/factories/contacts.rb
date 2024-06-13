FactoryBot.define do
  factory :contact do
    name { '山田太郎' }
    email { 'test@example.com' }
    message { 'お問い合わせ内容' }
    customer
  end
end
