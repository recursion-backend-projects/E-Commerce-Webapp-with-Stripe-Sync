class AddAdminRefToAdminAccounts < ActiveRecord::Migration[7.1]
  def change
    add_reference :admin_accounts, :admin, null: false, foreign_key: true
  end
end
