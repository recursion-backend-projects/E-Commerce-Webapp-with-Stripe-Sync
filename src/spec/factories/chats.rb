FactoryBot.define do
  factory :chat do
    status { :waiting_for_admin }
    customer
  end
end
