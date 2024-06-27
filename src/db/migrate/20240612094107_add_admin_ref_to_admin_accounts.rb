class AddAdminRefToAdminAccounts < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:admin_accounts, :admin_id)
      add_reference :admin_accounts, :admin, null: false, foreign_key: true
    else
      unless foreign_key_exists?(:admin_accounts, :admin_id)
        add_foreign_key :admin_accounts, :admins, column: :admin_id
      end
    end
  end
end
