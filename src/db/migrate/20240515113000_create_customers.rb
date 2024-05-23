class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :customer_account, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, [:customer_account_id, :address_id], unique: true
  end
end
