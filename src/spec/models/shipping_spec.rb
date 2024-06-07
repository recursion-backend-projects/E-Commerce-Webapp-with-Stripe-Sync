require 'rails_helper'

RSpec.describe Shipping, type: :model do
  let(:shipping) { create(:shipping) }

  it 'is valid with a carrier, tracking_number, order' do
    expect(shipping).to be_valid
  end

  it 'is invalid without a carrier' do
    shipping.carrier = nil
    shipping.valid?
    expect(shipping.errors[:carrier]).to include('は一覧にありません')
  end

  it 'is invalid without a tracking_number' do
    shipping.tracking_number = nil
    shipping.valid?
    expect(shipping.errors[:tracking_number]).to include('は不正な値です')
  end

  it 'is invalid without a status' do
    shipping.status = nil
    shipping.valid?
    expect(shipping.errors[:status]).to include('は一覧にありません')
  end

  it 'is invalid without a order' do
    shipping.order = nil
    shipping.valid?
    expect(shipping.errors[:order]).to include('を入力してください')
  end
end
