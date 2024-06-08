class ChangeZipCodeTypeInAddressesTable < ActiveRecord::Migration[7.1]
  def change
    change_column :addresses, :zip_code, :string
  end
end
