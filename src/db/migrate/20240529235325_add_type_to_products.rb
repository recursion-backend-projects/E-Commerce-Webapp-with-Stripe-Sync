class AddTypeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_type, :integer, default: 0
  end
end
