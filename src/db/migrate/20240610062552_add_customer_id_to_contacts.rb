class AddCustomerIdToContacts < ActiveRecord::Migration[7.1]
  def change
    add_reference :contacts, :customer, null: true, foreign_key: true
  end
end
