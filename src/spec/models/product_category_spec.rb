require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it 'is valid with a name' do
    expect(build(:product_category)).to be_valid
  end

  it 'is invalid without a name' do
    product_category = build(:product, name: nil)
    product_category.valid?
    expect(product_category.errors[:name]).to include('を入力してください')
  end
end
