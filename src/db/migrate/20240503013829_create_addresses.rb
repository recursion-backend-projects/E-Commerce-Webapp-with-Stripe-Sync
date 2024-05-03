class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :zipCode
      t.string :state
      t.string :city
      t.string :streetAddress
      t.string :streetAddress_2

      t.timestamps
    end

    add_index :addresses, :zipCode
    add_index :addresses, :city
    add_index :addresses, :state
    add_index :addresses, [:city, :zipCode]
  end
end
