require 'rails_helper'

RSpec.describe Customer::WishProductsController, type: :controller do

  let(:customer_account) { create(:customer_account) }
  let(:address) { create(:address) }
  let(:customer) { create(:customer, customer_account: customer_account, address: address) }
  let(:product) { create(:product) }
  let(:wish_product) { create(:wish_product, customer: customer, product: product) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(wish_product).to be_valid
    end

    it 'is not valid without a customer' do
      wish_product.customer = nil
      expect(wish_product).to_not be_valid
      expect(wish_product.errors[:customer]).to include('を入力してください')
    end

    it 'is not valid without a product' do
      wish_product.product = nil
      expect(wish_product).to_not be_valid
      expect(wish_product.errors[:product]).to include('を入力してください')
    end

    it 'is not valid with a duplicate customer and product combination' do
      wish_product.save
      duplicate_wish_product = build(:wish_product, customer: customer, product: product)
      expect(duplicate_wish_product).to_not be_valid
      expect(duplicate_wish_product.errors[:customer_id]).to include('この商品はすでにウィッシュリストに追加されています。')
    end
  end

  describe 'Associations' do
    it 'belongs to a customer' do
      expect(wish_product).to respond_to(:customer)
    end

    it 'belongs to a product' do
      expect(wish_product).to respond_to(:product)
    end
  end
end
