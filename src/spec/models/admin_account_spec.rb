require 'rails_helper'

RSpec.describe AdminAccount, type: :model do
  context 'when validating' do
    it 'is valid with valid attributes' do
      admin = build(:admin_account)
      expect(admin).to be_valid
    end

    context 'when email is nil' do
      it 'is not valid without an email' do
        admin = build(:admin_account, email: nil)
        expect(admin).not_to be_valid
      end

      it 'adds a correct error message for missing email' do
        admin = build(:admin_account, email: nil)
        admin.valid?
        expect(admin.errors[:email]).to include('を入力してください')
      end
    end

    context 'when password is nil' do
      it 'is not valid without a password' do
        admin = build(:admin_account, password: nil)
        expect(admin).not_to be_valid
      end

      it 'adds a correct error message for missing password' do
        admin = build(:admin_account, password: nil)
        admin.valid?
        expect(admin.errors[:password]).to include('を入力してください')
      end
    end

    context 'when password is too short' do
      it 'is not valid with a password shorter than 8 characters' do
        admin = build(:admin_account, password: 'short')
        admin.valid?
        expect(admin.errors[:password]).to include('は8文字以上で入力してください')
      end
    end

    context 'when password is too long' do
      it 'is not valid with a password longer than 128 characters' do
        long_password = 'a' * 129
        admin = build(:admin_account, password: long_password)
        admin.valid?
        expect(admin.errors[:password]).to include('は128文字以内で入力してください')
      end
    end

    context 'when password is not alphanumeric' do
      it 'is not valid with a password that is not a mix of letters and numbers' do
        customer = build(:admin_account, password: 'aaaaaaaa')
        customer.valid?
        expect(customer.errors[:password]).to include('は不正な値です')
      end
    end

    context 'with a duplicate email' do
      before do
        create(:admin_account, email: 'admin12345@example.com')
      end

      it 'is not valid with a non-unique email' do
        new_admin = build(:admin_account, email: 'admin12345@example.com')
        expect(new_admin).not_to be_valid
      end

      it 'adds a correct error message for duplicate email' do
        new_admin = build(:admin_account, email: 'admin12345@example.com')
        new_admin.valid?
        expect(new_admin.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
