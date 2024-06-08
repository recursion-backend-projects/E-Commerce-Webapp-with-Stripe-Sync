class AddShippingNameToCustomerAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_accounts, :shipping_name, :string
  end
end
