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
        admin.valid?  # バリデーションを明示的に実行
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
        admin.valid?  # バリデーションを明示的に実行
        expect(admin.errors[:password]).to include('を入力してください')
      end
    end

    context 'with a duplicate email' do
      before do
        create(:admin_account, email: 'admin@example.com')
      end

      it 'is not valid with a non-unique email' do
        new_admin = build(:admin_account, email: 'admin@example.com')
        expect(new_admin).not_to be_valid
      end

      it 'adds a correct error message for duplicate email' do
        new_admin = build(:admin_account, email: 'admin@example.com')
        new_admin.valid?  # バリデーションを明示的に実行
        expect(new_admin.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
