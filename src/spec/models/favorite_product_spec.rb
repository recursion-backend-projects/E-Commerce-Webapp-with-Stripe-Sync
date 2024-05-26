require 'rails_helper'

RSpec.describe FavoriteProduct, type: :model do
  let(:customer_account) { create(:customer_account) }
  let(:customer) { customer_account.customer }
  let(:product) { create(:product) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      favorite_product = build(:favorite_product, customer:, product:)
      expect(favorite_product).to be_valid
    end

    it 'is not valid without a customer' do
      favorite_product = build(:favorite_product, customer: nil, product:)
      expect(favorite_product).not_to be_valid
    end

    it 'adds an error message when customer is missing' do
      favorite_product = build(:favorite_product, customer: nil, product:)
      favorite_product.valid?
      expect(favorite_product.errors[:customer]).to include('を入力してください')
    end

    it 'is not valid without a product' do
      favorite_product = build(:favorite_product, customer:, product: nil)
      expect(favorite_product).not_to be_valid
    end

    it 'adds an error message when product is missing' do
      favorite_product = build(:favorite_product, customer:, product: nil)
      favorite_product.valid?
      expect(favorite_product.errors[:product]).to include('を入力してください')
    end

    it 'is not valid with a duplicate customer and product combination' do
      create(:favorite_product, customer:, product:)
      duplicate_favorite_product = build(:favorite_product, customer:, product:)
      expect(duplicate_favorite_product).not_to be_valid
    end

    it 'adds an error message for duplicate customer and product combination' do
      create(:favorite_product, customer:, product:)
      duplicate_favorite_product = build(:favorite_product, customer:, product:)
      duplicate_favorite_product.valid?
      expect(duplicate_favorite_product.errors[:customer_id]).to include('この商品はすでにお気に入りリストに追加されています。')
    end
  end
end
