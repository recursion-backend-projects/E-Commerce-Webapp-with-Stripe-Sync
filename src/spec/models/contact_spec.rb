require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { create(:contact) }

  describe 'Validations' do
    it 'has a valid factory' do
      expect(contact).to be_valid
    end

    it 'is valid with a customer_id' do
      contact.customer_id = nil
      expect(contact).to be_valid
    end

    it 'is invalid without a name' do
      contact.name = nil
      contact.valid?
      expect(contact.errors[:name]).to include('を入力してください')
    end

    it 'is invalid without a email' do
      contact.email = nil
      contact.valid?
      expect(contact.errors[:email]).to include('を入力してください')
    end

    it 'is invalid without a message' do
      contact.message = nil
      contact.valid?
      expect(contact.errors[:message]).to include('を入力してください')
    end

    it 'is invalid with a name longer than 50 characters' do
      contact.name = 'a' * 51
      contact.valid?
      expect(contact.errors[:name]).to include('は50文字以内で入力してください')
    end

    it 'is invalid email format' do
      contact.email = 'format.@test@example.com'
      contact.valid?
      expect(contact.errors[:email]).to include('の形式が不正です')
    end

    it 'is invalid with a message longer than 1000 characters' do
      contact.message = 'a' * 1001
      contact.valid?
      expect(contact.errors[:message]).to include('は1000文字以内で入力してください')
    end
  end
end
