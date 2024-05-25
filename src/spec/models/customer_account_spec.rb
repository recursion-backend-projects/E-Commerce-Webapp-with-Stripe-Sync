require 'rails_helper'

RSpec.describe CustomerAccount, type: :model do
  context 'when validating' do
    it 'is valid with valid attributes' do
      customer_account = build(:customer_account)
      expect(customer_account).to be_valid
    end

    context 'when email is nil' do
      it 'is not valid without an email' do
        customer_account = build(:customer_account, email: nil)
        expect(customer_account).not_to be_valid
      end

      it 'adds a correct error message for missing email' do
        customer_account = build(:customer_account, email: nil)
        customer_account.valid?
        expect(customer_account.errors[:email]).to include('を入力してください')
      end
    end

    context 'when password is nil' do
      it 'is not valid without a password' do
        customer_account = build(:customer_account, password: nil)
        expect(customer_account).not_to be_valid
      end

      it 'adds a correct error message for missing password' do
        customer_account = build(:customer_account, password: nil)
        customer_account.valid?
        expect(customer_account.errors[:password]).to include('を入力してください')
      end
    end

    context 'when password is too short' do
      it 'is not valid with a password shorter than 8 characters' do
        customer_account = build(:customer_account, password: 'short')
        customer_account.valid?
        expect(customer_account.errors[:password]).to include('は8文字以上で入力してください')
      end
    end

    context 'when password is too long' do
      it 'is not valid with a password longer than 128 characters' do
        long_password = 'a' * 129
        customer_account = build(:customer_account, password: long_password)
        customer_account.valid?
        expect(customer_account.errors[:password]).to include('は128文字以内で入力してください')
      end
    end

    context 'when password is not alphanumeric' do
      it 'is not valid with a password that is not a mix of letters and numbers' do
        customer_account = build(:customer_account, password: 'aaaaaaaa')
        customer_account.valid?
        expect(customer_account.errors[:password]).to include('は不正な値です')
      end
    end

    context 'with a duplicate email' do
      before do
        create(:customer_account, email: 'customer@example.com')
      end

      it 'is not valid with a non-unique email' do
        new_customer_account = build(:customer_account, email: 'customer@example.com')
        expect(new_customer_account).not_to be_valid
      end

      it 'adds a correct error message for duplicate email' do
        new_customer_account = build(:customer_account, email: 'customer@example.com')
        new_customer_account.valid?
        expect(new_customer_account.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
