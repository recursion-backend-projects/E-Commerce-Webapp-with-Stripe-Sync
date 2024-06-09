require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'product' do
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

  describe 'search and sort' do
    let(:category) { create(:product_category, name: '絵画') }
    let(:monalisa) { create(:product, name: 'モナリザ', price: 500, creator: 'ダヴィンチ', description: '美しいモナリザ', product_category: category) }
    let(:sunflower) { create(:product, name: 'ひまわり', price: 1000, creator: 'ゴッホ', description: '満開のひまわり', product_category: category) }
    let(:starry_night) { create(:product, name: '星月夜', price: 750, creator: 'ゴッホ', description: 'きれいない星月夜', product_category: category) }

    before do
      create(:product_review, product: monalisa, rating: 5)
      create(:product_review, product: sunflower, rating: 4)
      create(:product_review, product: starry_night, rating: 3)
    end

    it 'searches products' do
      search = described_class.ransack(name_or_description_or_creator_or_product_category_name_cont: 'モナリザ')
      results = search.result(distinct: true).to_a
      expect(results).to include(monalisa)
    end

    it 'searches products not include' do
      search = described_class.ransack(name_or_description_or_creator_or_product_category_name_cont: 'モナリザ')
      results = search.result(distinct: true).to_a
      expect(results).not_to include(sunflower, starry_night)
    end

    it 'searches products not found' do
      search = described_class.ransack(name_or_description_or_creator_or_product_category_name_cont: 'ピカソ')
      results = search.result(distinct: true).to_a
      expect(results).to be_empty
    end

    it 'searches products by category' do
      search = described_class.joins(:product_category).ransack(product_category_name_eq: '絵画')
      results = search.result(distinct: true).to_a
      expect(results).to include(monalisa, sunflower, starry_night)
    end

    it 'sorts products by average rating' do
      search = described_class.ransack(sorts: 'average_rating desc')
      results = search.result(distinct: true).to_a
      expect(results).to eq([monalisa, sunflower, starry_night])
    end

    it 'sorts products by high price' do
      search = described_class.ransack(sorts: 'price desc')
      results = search.result(distinct: true).to_a
      expect(results).to eq([sunflower, starry_night, monalisa])
    end

    it 'sorts products by low price' do
      search = described_class.ransack(sorts: 'price asc')
      results = search.result(distinct: true).to_a
      expect(results).to eq([monalisa, starry_night, sunflower])
    end
  end
end
