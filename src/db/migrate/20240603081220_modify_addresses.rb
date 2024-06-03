class ModifyAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :state, :string
    remove_column :addresses, :city, :string
    add_column :addresses, :prefecture_id, :integer
  end
end
