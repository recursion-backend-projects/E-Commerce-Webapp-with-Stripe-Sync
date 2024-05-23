class AddAddressableToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :addressable, polymorphic: true, index: true
  end
end
