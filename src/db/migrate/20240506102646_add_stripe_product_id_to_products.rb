class AddStripeProductIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :stripe_product_id, :string
  end
end
