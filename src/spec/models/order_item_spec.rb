require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item) }

  it 'is valid with quantity, order, product' do
    expect(order_item).to be_valid
  end

  it 'is invalid without quantity' do
    order_item.quantity = nil
    order_item.valid?
    expect(order_item.errors[:quantity]).to include('を入力してください')
  end

  it 'is invalid without order' do
    order_item.order = nil
    order_item.valid?
    expect(order_item.errors[:order]).to include('を入力してください')
  end

  it 'is invalid without product' do
    order_item.product = nil
    order_item.valid?
    expect(order_item.errors[:product]).to include('を入力してください')
  end
end
