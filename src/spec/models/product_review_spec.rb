require 'rails_helper'

RSpec.describe ProductReview, type: :model do
  let(:customer_account) { create(:customer_account) }
  let(:customer) { customer_account.customer }
  let(:product) { create(:product) }
  let(:product_review) { build(:product_review, customer:, product:) }

  describe 'Validations' do
    it 'has a valid factory' do
      expect(product_review).to be_valid
    end

    it 'is invalid without a customer' do
      product_review.customer = nil
      expect(product_review).not_to be_valid
    end

    it 'is invalid without a product' do
      product_review.product = nil
      expect(product_review).not_to be_valid
    end

    it 'is invalid without a title' do
      product_review.title = nil
      product_review.valid?
      expect(product_review.errors[:title]).to include('を入力してください')
    end

    it 'is invalid without a review' do
      product_review.review = nil
      product_review.valid?
      expect(product_review.errors[:review]).to include('を入力してください')
    end

    it 'is invalid without a rating' do
      product_review.rating = nil
      product_review.valid?
      expect(product_review.errors[:rating]).to include('を入力してください')
    end

    it 'rating must be included in the list' do
      product_review.rating = nil
      product_review.valid?
      expect(product_review.errors[:rating]).to include('は一覧にありません')
    end

    it 'is invalid with a title longer than 50 characters' do
      product_review.title = 'a' * 51
      product_review.valid?
      expect(product_review.errors[:title]).to include('は50文字以内で入力してください')
    end

    it 'is invalid with a review longer than 400 characters' do
      product_review.review = 'a' * 401
      product_review.valid?
      expect(product_review.errors[:review]).to include('は400文字以内で入力してください')
    end
  end
end
