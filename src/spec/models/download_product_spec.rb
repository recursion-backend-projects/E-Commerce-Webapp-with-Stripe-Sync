require 'rails_helper'

RSpec.describe DownloadProduct, type: :model do
  let(:customer) { create(:customer) }
  let(:product) { create(:product) }

  it 'is valid with valid attributes' do
    download_product = DownloadProduct.new(customer: customer, product: product)
    expect(download_product).to be_valid
  end

  it 'is not valid without a customer' do
    download_product = DownloadProduct.new(customer: nil, product: product)
    expect(download_product).to_not be_valid
    expect(download_product.errors[:customer]).to include("を入力してください")
  end

  it 'is not valid without a product' do
    download_product = DownloadProduct.new(customer: customer, product: nil)
    expect(download_product).to_not be_valid
    expect(download_product.errors[:product]).to include("を入力してください")
  end
end
