class AddPhoneNumberToCustomerAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_accounts, :phone_number, :string
  end
end
