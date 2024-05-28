require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:login_user_order) { create(:login_user_order) }

  context 'when order is a guest order' do
    it 'is valid with a order_number, total, order_date, ,guest_email, receipt_url' do
      expect(order).to be_valid
    end

    it 'is invalid without an order_number' do
      order.order_number = nil
      order.valid?
      expect(order.errors[:order_number]).to include('を入力してください')
    end

    it 'is invalid without a total' do
      order.total = nil
      order.valid?
      expect(order.errors[:total]).to include('を入力してください')
    end

    it 'is invalid without a order_date' do
      order.order_date = nil
      order.valid?
      expect(order.errors[:order_date]).to include('を入力してください')
    end

    it 'is invalid with a invalid guest_email' do
      order.guest_email = '無効な文字列'
      order.valid?
      expect(order.errors[:guest_email]).to include('は不正な値です')
    end

    it 'is invalid without a receipt_url' do
      order.receipt_url = nil
      order.valid?
      expect(order.errors[:receipt_url]).to include('は不正な値です')
    end
  end

  context 'when order is associated with a customer' do
    it 'is valid with a order_number, total, order_date, customer, receipt_url' do
      expect(login_user_order).to be_valid
    end

    it 'is invalid without an order_number' do
      login_user_order.order_number = nil
      login_user_order.valid?
      expect(login_user_order.errors[:order_number]).to include('を入力してください')
    end

    it 'is invalid without a total' do
      login_user_order.total = nil
      login_user_order.valid?
      expect(login_user_order.errors[:total]).to include('を入力してください')
    end

    it 'is invalid without a order_date' do
      login_user_order.order_date = nil
      login_user_order.valid?
      expect(login_user_order.errors[:order_date]).to include('を入力してください')
    end

    it 'is invalid without a receipt_url' do
      login_user_order.receipt_url = nil
      login_user_order.valid?
      expect(login_user_order.errors[:receipt_url]).to include('を入力してください')
    end
  end
end
