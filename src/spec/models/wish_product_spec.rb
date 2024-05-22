require 'rails_helper'

RSpec.describe WishProduct, type: :model do
  let(:customer_account) { create(:customer_account) }
  let(:address) { create(:address, addressable: customer_account) }
  let(:customer) { create(:customer, customer_account: customer_account, address: address) }
  let(:product) { create(:product) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      wish_product = build(:wish_product, customer: customer, product: product)
      expect(wish_product).to be_valid
    end

    it 'is not valid without a customer' do
      wish_product = build(:wish_product, customer: nil, product: product)
      expect(wish_product).not_to be_valid
    end

    it 'adds an error message when customer is missing' do
      wish_product = build(:wish_product, customer: nil, product: product)
      wish_product.valid?
      expect(wish_product.errors[:customer]).to include('を入力してください')
    end

    it 'is not valid without a product' do
      wish_product = build(:wish_product, customer: customer, product: nil)
      expect(wish_product).not_to be_valid
    end

    it 'adds an error message when product is missing' do
      wish_product = build(:wish_product, customer: customer, product: nil)
      wish_product.valid?
      expect(wish_product.errors[:product]).to include('を入力してください')
    end

    it 'is not valid with a duplicate customer and product combination' do
      create(:wish_product, customer: customer, product: product)
      duplicate_wish_product = build(:wish_product, customer: customer, product: product)
      expect(duplicate_wish_product).not_to be_valid
    end

    it 'adds an error message for duplicate customer and product combination' do
      create(:wish_product, customer: customer, product: product)
      duplicate_wish_product = build(:wish_product, customer: customer, product: product)
      duplicate_wish_product.valid?
      expect(duplicate_wish_product.errors[:customer_id]).to include('この商品はすでにウィッシュリストに追加されています。')
    end
  end
end
