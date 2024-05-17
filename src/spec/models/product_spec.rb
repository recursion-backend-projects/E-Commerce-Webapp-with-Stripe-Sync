require 'rails_helper'

RSpec.describe Product do
  let(:product) { create(:product) }

  it 'is valid with a name, price, description, product_category_id' do
    expect(product).to be_valid
  end

  it 'is invalid without a name' do
    product.name = nil
    product.valid?
    expect(product.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without a price' do
    product.price = nil
    product.valid?
    expect(product.errors[:price]).to include('を入力してください')
  end

  it 'is invalid without a description' do
    product.description = nil
    product.valid?
    expect(product.errors[:description]).to include('を入力してください')
  end
end
