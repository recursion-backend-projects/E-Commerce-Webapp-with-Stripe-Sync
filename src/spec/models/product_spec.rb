require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:valid_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/valid_image.jpg'), 'image/jpeg') }
  let(:invalid_type_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid_image.txt'), 'text/plain') }
  let(:invalid_size_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/large_image.jpg'), 'image/jpeg') }

  it 'is valid with a name, price, description, product_category_id' do
    product = build(:product)
    expect(product).to be_valid
  end

  it 'is invalid without a name' do
    product = build(:product, name: nil)
    product.valid?
    expect(product.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without a price' do
    product = build(:product, price: nil)
    product.valid?
    expect(product.errors[:price]).to include('を入力してください')
  end

  it 'is invalid without a description' do
    product = build(:product, description: nil)
    product.valid?
    expect(product.errors[:description]).to include('を入力してください')
  end

  context 'with image validation' do
    it 'is valid with a valid image' do
      product = build(:product)
      product.images.attach(valid_image)
      expect(product).to be_valid
    end

    it 'is invalid with a non-image file' do
      product = build(:product)
      product.images.attach(invalid_type_image)
      product.valid?
      expect(product.errors[:images]).to include('のContent Typeが不正です')
    end

    it 'is invalid with an image larger than 3MB' do
      product = build(:product)
      product.images.attach(invalid_size_image)
      product.valid?
      expect(product.errors[:images]).to include('ファイル サイズは 3MB 未満にする必要があります (現在のサイズは 3.11MB)')
    end
  end
end
