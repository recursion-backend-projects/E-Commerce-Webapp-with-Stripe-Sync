require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer_account) { create(:customer_account) }
  let(:address) { create(:address, addressable: customer_account) }
  let(:customer) { create(:customer, customer_account:, address:) }

  describe 'Associations' do
    it 'belongs to a customer_account' do
      expect(customer.customer_account).to eq(customer_account)
    end

    it 'belongs to an address' do
      expect(customer.address).to eq(address)
    end
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(customer).to be_valid
    end

    it 'is not valid without a customer_account' do
      customer.customer_account = nil
      expect(customer).not_to be_valid
    end
  end
end
