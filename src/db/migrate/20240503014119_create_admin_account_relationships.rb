class CreateAdminAccountRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_account_relationships do |t|
      t.bigint :admin_account_id, null: false
      t.bigint :address_id, null: false
      t.timestamps

      t.index :admin_account_id
      t.index :address_id
      t.index [:admin_account_id, :address_id], unique: true

      t.foreign_key :admin_accounts, column: :admin_account_id
      t.foreign_key :addresses, column: :address_id
    end
  end
end
