require 'rails_helper'

RSpec.describe DownloadProduct, type: :model do
  let(:customer) { create(:customer) }
  let(:product) { create(:product) }

  it 'is valid with valid attributes' do
    download_product = described_class.new(customer:, product:)
    expect(download_product).to be_valid
  end

  context 'without a customer' do
    let(:download_product) { described_class.new(customer: nil, product:) }

    it 'is not valid' do
      expect(download_product).not_to be_valid
    end

    it 'has an error on customer' do
      download_product.valid?
      expect(download_product.errors[:customer]).to include('を入力してください')
    end
  end

  context 'without a product' do
    let(:download_product) { described_class.new(customer:, product: nil) }

    it 'is not valid' do
      expect(download_product).not_to be_valid
    end

    it 'has an error on product' do
      download_product.valid?
      expect(download_product.errors[:product]).to include('を入力してください')
    end
  end
end
