require 'rails_helper'

RSpec.describe WishProductToken, type: :model do
  let(:customer) { create(:customer) }

  it 'is valid with token with customer_id' do
    wish_product_token = described_class.new(token: described_class.generate_token, customer:)
    expect(wish_product_token).to be_valid
  end

  it 'is invalid without a token' do
    wish_product_token = described_class.new(token: nil)
    wish_product_token.valid?
    expect(wish_product_token.errors[:token]).to include('を入力してください')
  end

  it 'is invalid without a customer' do
    wish_product_token = described_class.new(customer_id: nil)
    wish_product_token.valid?
    expect(wish_product_token.errors[:customer]).to include('を入力してください')
  end
end
