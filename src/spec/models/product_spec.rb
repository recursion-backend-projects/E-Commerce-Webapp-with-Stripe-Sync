require 'rails_helper'

RSpec.describe Product do
  it 'is valid with a name, price, description, product_category_id' do
    expect(build(:product)).to be_valid
  end

  it 'is invalid without a name' do
    product = build(:product, name: nil)
    product.valid?
    expect(product.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    product = build(:product, price: nil)
    product.valid?
    expect(product.errors[:price]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    product = build(:product, description: nil)
    product.valid?
    expect(product.errors[:description]).to include("can't be blank")
  end
end
