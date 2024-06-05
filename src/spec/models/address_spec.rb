require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:customer) { create(:customer) }

  it 'is valid with a addressable' do
    address = described_class.new(addressable: customer)
    expect(address).to be_valid
  end

  it 'allows NNN-NNNN format, blank, or nil for a zip code' do
    address = build(:address)
    expect(address).to be_valid

    address.zip_code = nil
    expect(address).to be_valid

    address.zip_code = ''
    expect(address).to be_valid
  end

  it 'does not allow formats other than NNN-NNNN for a zip code' do
    address = build(:address)

    # ハイフンなし
    address.zip_code = '1234567'
    address.valid?
    expect(address.errors[:zip_code]).to include('の形式が不正です（例:123-4567）')

    # 桁数がおかしい
    address.zip_code = '1234-567'
    expect(address.errors[:zip_code]).to include('の形式が不正です（例:123-4567）')

    # 数字以外が入っている
    address.zip_code = 'A12-567'
    expect(address.errors[:zip_code]).to include('の形式が不正です（例:123-4567）')
  end

  it 'allows values from 1 to 47, blank or nil for a prefecture_id' do
    address = build(:address)
    expect(address).to be_valid

    address.prefecture_id = ''
    expect(address).to be_valid

    address.prefecture_id = nil
    expect(address).to be_valid
  end

  it 'does not allow other than 1 to 47 for a prefecture_id' do
    address = build(:address)

    address.prefecture_id = 0
    address.valid?
    expect(address.errors[:prefecture_id]).to include('は1..47の範囲に含めてください')

    address.prefecture_id = 48
    expect(address.errors[:prefecture_id]).to include('は1..47の範囲に含めてください')
  end

  it 'allows a maximum length of 200, blank, or nil for a street address' do
    address = build(:address)

    address.street_address = 'a' * 200
    expect(address).to be_valid

    address.street_address = 'a' * 199
    expect(address).to be_valid

    address.street_address = ''
    expect(address).to be_valid

    address.street_address = nil
    expect(address).to be_valid
  end

  it 'does not allow more than 200 characters for a street address' do
    address = build(:address)
    address.street_address = 'a' * 201
    address.valid?
    expect(address.errors[:street_address]).to include('は200文字以内で入力してください')
  end

  it 'allows a maximum length of 200, blank, or nil for a street address_2' do
    address = build(:address)

    address.street_address_2 = 'a' * 200
    expect(address).to be_valid

    address.street_address_2 = 'a' * 199
    expect(address).to be_valid

    address.street_address_2 = ''
    expect(address).to be_valid

    address.street_address_2 = nil
    expect(address).to be_valid
  end

  it 'does not allow more than 200 characters for a street address 2' do
    address = build(:address)
    address.street_address_2 = 'a' * 201
    address.valid?
    expect(address.errors[:street_address_2]).to include('は200文字以内で入力してください')
  end
end
