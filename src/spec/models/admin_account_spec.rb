# spec/models/admin_account_spec.rb
require 'rails_helper'

RSpec.describe AdminAccount, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      admin = build(:admin_account)
      expect(admin).to be_valid
    end

    it 'requires an email' do
      admin = build(:admin_account, email: nil)
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("を入力してください")
    end

    it 'requires a password' do
      admin = build(:admin_account, password: nil)
      expect(admin).not_to be_valid
      expect(admin.errors[:password]).to include("を入力してください")
    end

    it 'has a unique email' do
      create(:admin_account, email: "admin@example.com")
      new_admin = build(:admin_account, email: "admin@example.com")
      expect(new_admin).not_to be_valid
      expect(new_admin.errors[:email]).to include("はすでに存在します")
    end
  end
end
