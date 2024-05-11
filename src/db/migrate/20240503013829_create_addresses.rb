class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :zip_code
      t.string :state
      t.string :city
      t.string :street_address
      t.string :street_address_2

      t.timestamps
    end

    add_index :addresses, :zip_code
    add_index :addresses, :city
    add_index :addresses, :state
    add_index :addresses, %i[city zip_code]
  end
end
