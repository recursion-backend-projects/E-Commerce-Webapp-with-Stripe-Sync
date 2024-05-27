class UpdateCustomerAndCustomerAccountTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :address_id, :bigint
    remove_column :customers, :customer_account_id, :bigint
    add_reference :customer_accounts, :customer, foreign_key: true
  end
end
