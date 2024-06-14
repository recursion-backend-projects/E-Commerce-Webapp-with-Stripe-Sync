require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:customer) { create(:customer) }

  it 'valid with a status, customer' do
    chat = described_class.new(status: :waiting_for_admin, customer:)
    expect(chat).to be_valid
  end

  it 'is invalid without a status' do
    chat = described_class.new(status: nil)
    chat.valid?
    expect(chat).not_to be_valid
  end

  it 'is invalid without a customer' do
    chat = described_class.new(status: :waiting_for_admin, customer: nil)
    chat.valid?
    expect(chat).not_to be_valid
  end
end
